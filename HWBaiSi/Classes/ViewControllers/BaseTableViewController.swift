//
//  BaseTableViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/24.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import MJRefresh

let kTopicTableViewCellKey = "kTopicTableViewCellKey"

class BaseTableViewController: UITableViewController {

    var info = [String : Any]()
    var dataModels = [HWTopic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置通用背景颜色
        self.view.backgroundColor = UIColor.defaultLightGray
        
        let inset = UIEdgeInsets(top: 44+35, left: 0, bottom: 49, right: 0)
        self.tableView.contentInset = inset
        self.tableView.scrollIndicatorInsets = inset
        self.tableView.register(HWTopicTableViewCell.self, forCellReuseIdentifier: kTopicTableViewCellKey)
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.loadData()
        })
        self.tableView.mj_header.isAutomaticallyChangeAlpha = true
        self.tableView.mj_header.beginRefreshing()
        
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            self.loadData()
        })
    }
    
    func loadData() {
        assertionFailure("需要重写")
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }

}
