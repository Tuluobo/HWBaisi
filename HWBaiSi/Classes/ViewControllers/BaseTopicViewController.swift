//
//  BaseTopicViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/24.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import MJRefresh

let kTopicTableViewCellKey = "topicCell"

class BaseTopicViewController: UITableViewController {

    var topicType: Int {
        return 1
    }
    
    var info = [String : Any]()
    var dataModels = [HWTopic]()
    var cellHeightCaches = [IndexPath : CGFloat]()
    var fetchTask: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置通用背景颜色
        view.backgroundColor = UIColor.defaultLightGray
        /// tableView 设置
        tableView.contentInset = UIEdgeInsets(top: 44+35, left: 0, bottom: 49, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        /// 注册nib
        let nib = UINib(nibName: "HWTopicTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: kTopicTableViewCellKey)
        /// 下拉，上拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.fetchTask?.cancel()
            self.fetchTask = self.loadData()
        })
        tableView.mj_header.isAutomaticallyChangeAlpha = true
        tableView.mj_header.beginRefreshing()
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.fetchTask?.cancel()
            self.fetchTask = self.loadData()
        })
        tableView.mj_footer.isAutomaticallyChangeAlpha = true
    }
    
    func loadData() -> URLSessionTask? {
        let maxtime = tableView.mj_header.isRefreshing() ? nil : info["maxtime"] as? String
        /// type: 1 表示全部
        let task = RESTfulManager.sharedInstance.fetchTopicData(type: topicType, maxtime: maxtime) { (infoDict, data, error) in
            // 停止刷新
            if self.tableView.mj_header.isRefreshing() {
                self.tableView.mj_header.endRefreshing()
            } else {
                self.tableView.mj_footer.endRefreshing()
            }
            // 处理数据
            if let e = error {
                HWLog("\(e)")
                return
            }
            // 正确的数据
            self.info = infoDict!
            if self.tableView.mj_header.isRefreshing() {
                self.dataModels = data!
            } else {
                self.dataModels += data!
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return task
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTopicTableViewCellKey, for: indexPath) as! HWTopicTableViewCell
        
        cell.model = dataModels[indexPath.item]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellHeight = cellHeightCaches[indexPath] {
            cell.frame.size.height = cellHeight - 10
        }
        let cell = cell as! HWTopicTableViewCell
        let cellFrame = cell.bottomView.frame
        let cellHeight = cellFrame.size.height+cellFrame.origin.y
        cellHeightCaches[indexPath] = cellHeight
        cell.frame.size.height = cellHeight - 10
    }
}
