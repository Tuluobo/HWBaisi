//
//  HWAllViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/24.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWAllViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadData() {
        let maxtime = tableView.mj_header.isRefreshing() ? nil : info["maxtime"] as? String
        /// type: 1 表示全部
        RESTfulManager.sharedInstance.fetchTopicData(type: 1, maxtime: maxtime) { (infoDict, data, error) in
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
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTopicTableViewCellKey, for: indexPath) as! HWTopicTableViewCell
        let model = dataModels[indexPath.item]
        cell.textLabel?.text = "\(model.id!):\(model.screen_name!):\(model.type!)"
        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
