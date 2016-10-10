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
        self.commentTableView.backgroundColor = UIColor.defaultLightGray
        self.commentTableView.separatorStyle = .none
        self.commentTableView.register(HWCommentHeaderView.self, forHeaderFooterViewReuseIdentifier: kHeaderID)
        
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
        // topic cell view
        let xib = UINib(nibName: "HWTopicTableViewCell", bundle: nil)
        let topicView = xib.instantiate(withOwner: HWTopicTableViewCell.self, options: nil).first as! HWTopicTableViewCell
        topicView.model = topic
        // headerView
        let headerView = UIView()
        headerView.backgroundColor = UIColor.randomColor
        headerView.frame.size.height = topic.cellHeight
        headerView.addSubview(topicView)
        self.commentTableView.tableHeaderView = headerView
    }
    
    private func refreshData() -> URLSessionTask? {
        if commentTableView.mj_header.isRefreshing() {
            lastcid = nil
        }
        let task = RESTfulManager.sharedInstance.fetchCommentData(data_id: topic.id, lastcid: lastcid) { (data, error) in
            // 停止刷新
            if self.commentTableView.mj_header.isRefreshing() {
                self.commentTableView.mj_header.endRefreshing()
            } else {
                self.commentTableView.mj_footer.endRefreshing()
            }
            if let e = error {
                HWLog("请求出现错误：\(e)")
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? HWCommentTableViewCell {
            cell.frame.size.height = cell.commentLabel.frame.origin.y + cell.commentLabel.frame.size.height + 20
        }
    }
    
    // MARK: - 这是Section Header的设置
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if commentItems[section].count > 0 {
            return section == 0 ? 44 : 22
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

// MARK: - HWCommentTableViewCell 类
class HWCommentTableViewCell: UITableViewCell {
    
    var comment: HWComment? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var voiceComment: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.size.height -= 1
            super.frame = newFrame
        }
    }
    
    private func updateUI() {
        commentLabel.isHidden = true
        voiceComment.isHidden = true
        nickNameLabel.text = nil
        likeNumberLabel.text = nil
        
        guard let model = comment else {
            return
        }
        // 头像
        profileImageView.sd_setImage(with: URL(string: model.user.profile_image ?? ""), placeholderImage: UIImage(named: "defaultUserIcon")!.circleImage(), options: [], completed: { (image, error, _, _) in
            if let img = image {
                self.profileImageView.image = img.circleImage()
            }
        })
        // 性别
        if model.user.sex == "f" {
            genderImageView.image = UIImage(named:"Profile_womanIcon")
        } else {
            genderImageView.image = UIImage(named:"Profile_manIcon")
        }
        // 昵称
        nickNameLabel.text = model.user.username
        // 评论内容
        if model.voiceuri.hasPrefix("http") {
            voiceComment.isHidden = false
            HWLog("\(model.voiceuri)")
        } else {
            commentLabel.text = model.content
            commentLabel.isHidden = false
        }
        // 喜欢的数
        likeNumberLabel.text = model.like_count.stringValue
        
    }
    
    @IBAction func clickedLikeBtn() {
        guard let model = comment else {
            return
        }
        likeBtn.isSelected = !likeBtn.isSelected
        var likeCount = model.like_count.intValue
        // TODO: 这里需要与服务器通信
        if likeBtn.isSelected {
            likeCount += 1
        } else {
            likeCount -= 1
        }
        model.like_count = NSNumber(value: likeCount)
        likeNumberLabel.text = model.like_count.stringValue
    }
}

