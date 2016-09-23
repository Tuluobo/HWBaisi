//
//  HWTableCollectionViewCell.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

private let kTableViewCellkey = "tableCell"

class HWTableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension HWTableCollectionViewCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellkey, for: indexPath)
        return cell
    }
    
}
