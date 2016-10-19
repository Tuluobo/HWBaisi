//
//  HWCommentViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/10/1.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import MJRefresh

fileprivate let kHeaderID = "headerID"

class HWCommentViewController: BaseViewController {
    
    var topic: HWTopic!
    var commentItems = [[HWComment]]()  // 二维数组放的是最热评论和一般评论
    var lastcid: String?
    var fetchTask: URLSessionTask?
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentBarBottomMargin: NSLayoutConstraint!
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "评论"
        self.commentTableView.backgroundColor = UIColor.hw_lightGray
        self.commentTableView.separatorStyle = .none
        self.commentTableView.register(HWCommentHeaderView.self, forHeaderFooterViewReuseIdentifier: kHeaderID)
        self.commentTableView.estimatedRowHeight = 120
        self.commentTableView.rowHeight = UITableViewAutomaticDimension
        
        setupThisTopic()
        
        /// 下拉，上拉刷新
        commentTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.fetchTask?.cancel()
            self.fetchTask = self.refreshData()
        })
        commentTableView.mj_header.isAutomaticallyChangeAlpha = true
        commentTableView.mj_header.beginRefreshing()
        
        commentTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.fetchTask?.cancel()
            self.fetchTask = self.self.refreshData()
        })
        commentTableView.mj_footer.isAutomaticallyChangeAlpha = true
        
        // 监听键盘变化
        NotificationCenter.default.addObserver(self, selector: #selector(changeTextFieldFrame), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - 内部方法
    private func setupThisTopic() {
        // 临时调整model
        let tempComment = topic.top_cmt
        topic.top_cmt.removeAll()
        topic.setCellHeight(height: 0)
        // headerView
        let headerView = UIView()
        // topic cell view
        let xib = UINib(nibName: "HWTopicTableViewCell", bundle: nil)
        let topicView = xib.instantiate(withOwner: HWTopicTableViewCell.self, options: nil).first as! HWTopicTableViewCell
        topicView.model = topic
        topicView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: topic.cellHeight)
        headerView.addSubview(topicView)
        // 设置 header 高度
        headerView.frame.size.height = topicView.frame.size.height + 10 * 2
        // 设置 header
        self.commentTableView.tableHeaderView = headerView
        // 回复model
        topic.top_cmt = tempComment
        topic.setCellHeight(height: 0)
    }
    
    private func refreshData() -> URLSessionTask? {
        if commentTableView.mj_header.isRefreshing() {
            lastcid = nil
        }
        let task = RESTfulManager.sharedInstance.fetchCommentData(data_id: topic.id, lastcid: lastcid) { (total, data, error) in
            // 停止刷新
            if self.commentTableView.mj_header.isRefreshing() {
                self.commentTableView.mj_header.endRefreshing()
            }
            if let e = error {
                HWLog("请求出现错误：\(e)")
                if self.commentTableView.mj_footer.isRefreshing() {
                    self.commentTableView.mj_footer.endRefreshing()
                }
                return
            }
            if self.commentTableView.mj_header.isRefreshing() {
                 self.commentItems = data!
            } else {
                self.commentItems[1] += data![1]
            }
            if let last = data![1].last {
                self.lastcid = last.id
            }
            if self.commentTableView.mj_footer.isRefreshing() {
                if total == self.commentItems[1].count {
                    self.commentTableView.mj_footer.endRefreshingWithNoMoreData()
                } else {
                    self.commentTableView.mj_footer.endRefreshing()
                }
            }
            DispatchQueue.main.async {
                self.commentTableView.reloadData()
            }
        }
        return task
    }
    
    @objc private func changeTextFieldFrame(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval, let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            self.commentBarBottomMargin.constant = kScreenHeight - keyboardFrame.cgRectValue.origin.y
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }
    }

}

// MARK: - UIScrollViewDelegate 代理
extension HWCommentViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.commentTextField.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HWCommentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return commentItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! HWCommentTableViewCell
        cell.comment = commentItems[indexPath.section][indexPath.row]
        return cell
    }
    
    // MARK: - 这是Section Header的设置
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if commentItems[section].count > 0 {
            return 24
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kHeaderID) as! HWCommentHeaderView
        if section == 0 && commentItems[0].count > 0 {
            headerView.textLabel?.text = "最热评论"
            return headerView
        }else if section == 1 && commentItems[1].count > 0{
            headerView.textLabel?.text = "最新评论"
            return headerView
        }
        return nil
    }
    
}

