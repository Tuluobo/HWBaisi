//
//  MeViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import AFNetworking
import SDWebImage

class MeViewController: UITableViewController {
	
    @IBOutlet weak var nightModeBtn: UIBarButtonItem!
    @IBOutlet weak var tagViewCell: HWTagsViewCell!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
        self.view.backgroundColor = UIColor.defaultLightGray
		self.navigationItem.title = "我"
        self.tableView.contentInset = UIEdgeInsetsMake(-24, 0, -20, 0)
        // 获取 Tag 数据
        self.updateTagsData()
	}
	
    // MARK: 内部方法
    private func updateTagsData() {
        RESTfulManager.sharedInstance.fetchTags { (data, error) in
            if let e = error {
                HWLog("\(e)")
                return
            }
            self.tagViewCell.tagData = data!
        }
    }

    // MARK: UITableView 的 delegate 和 dataSource
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundView = UIImageView(image: UIImage(named: "mainCellBackground"))
    }
    
    // MARK: 用户响应方法
    @IBAction func clickedNightModeBtn(_ sender: AnyObject) {
        HWLog("夜间模式")
    }
    
    
}

// MARK: HWTagsViewCell
fileprivate let kTagCollectionCellKey = "tagCollectionCell"
class HWTagsViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tagData = [[String: Any]]() {
        didSet {
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HWTagsViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTagCollectionCellKey, for: indexPath) as! HWTagCollectionViewCell
        cell.model = tagData[indexPath.item]
        return cell
    }
}

// MARK: HWTagCollectionViewCell
class HWTagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.cyan
    }
    
    var model: [String: Any]? {
        didSet {
            updateCellUI()
        }
    }
    private func updateCellUI() {
        tagImageView.image = nil
        tagNameLabel.text = nil
        guard let data = model else { return }
        tagNameLabel.text = data["name"] as? String
        guard let iconURLStr = data["icon"] as? String else { return }
        tagImageView.sd_setImage(with: URL(string:iconURLStr))
    }
}
