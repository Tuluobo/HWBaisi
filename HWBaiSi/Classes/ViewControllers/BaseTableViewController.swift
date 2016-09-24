//
//  BaseTableViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/24.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var dataModels = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModels.count
    }

}
