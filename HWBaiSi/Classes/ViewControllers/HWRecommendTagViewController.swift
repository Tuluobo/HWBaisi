//
//  HWRecommendTagViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

private let kRecommendCellKey = "recommendCell"

class HWRecommendTagViewController: UITableViewController {

    var recommendTags = [HWRecommendTag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refresh()
    }
    
    private func refresh() {
        RESTfulManager.sharedInstance.fetchRecommendTags { (data, error) in
            if let e = error {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
