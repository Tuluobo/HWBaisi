//
//  HWRecommendTagViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import SVProgressHUD

private let kRecommendCellKey = "recommendCell"

class HWRecommendTagViewController: UITableViewController {

    var recommendTags = [HWRecommendTag]()
    private var fetchTask: URLSessionTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "推荐标签"
        tableView.backgroundColor = UIColor.hw_lightGray
        tableView.rowHeight = 68.0
        tableView.separatorStyle = .none
        /// 更新数据源
        refresh()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fetchTask?.cancel()
        SVProgressHUD.dismiss()
    }
    
    private func refresh() {
        SVProgressHUD.show()
        fetchTask = RESTfulManager.sharedInstance.fetchRecommendTags { (data, error) in
            SVProgressHUD.dismiss()
            if let e = error {
                if e._code != NSURLErrorCancelled {
                    SVProgressHUD.showError(withStatus: "网络连接错误")
                }
                HWLog("\(e)")
                return
            }
            self.recommendTags = data! 
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recommendTags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kRecommendCellKey, for: indexPath) as! HWRecommendTagCell
        cell.tagModel = recommendTags[indexPath.item]
        return cell
    }

}
