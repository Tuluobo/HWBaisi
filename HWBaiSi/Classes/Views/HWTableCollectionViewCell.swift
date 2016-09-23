//
//  HWTableCollectionViewCell.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

private let kTableViewCellkey = "tableCell"

// MARK: collectionView 中的 Cell
class HWTableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: HWContentTableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
}

extension HWTableCollectionViewCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableView.contentModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellkey, for: indexPath) as! HWConetentTableViewCell
        cell.model = self.tableView.contentModels[indexPath.item]
        return cell
    }
    
}
