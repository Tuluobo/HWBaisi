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

// 常量
fileprivate let rowItemCount = 4
fileprivate let kTagCollectionCellKey = "tagCollectionCell"
fileprivate let mainSize = UIScreen.main.bounds.size
fileprivate let aspectWH: CGFloat = 5.0/4.0
fileprivate let itemW = mainSize.width / CGFloat(rowItemCount)
fileprivate let itemH = itemW * aspectWH

class MeViewController: UITableViewController {
	
    @IBOutlet weak var nightModeBtn: UIBarButtonItem!
    @IBOutlet weak var tagViewCell: HWTagsViewCell!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
		tagViewCell.delegate = self
        
        self.view.backgroundColor = UIColor.hw_lightGray
		self.navigationItem.title = "我"
        self.tableView.contentInset = UIEdgeInsetsMake(-24, 0, -20, 0)
        // 获取 Tag 数据
        self.updateSquareData()
	}
	
    // MARK: 内部方法
    private func updateSquareData() {
        RESTfulManager.sharedInstance.fetchSquareTags { (data, error) in
            if let e = error {
                HWLog("\(e)")
                return
            }
            self.tagViewCell.squareData = data!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: UITableView 的 delegate 和 dataSource
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundView = UIImageView(image: UIImage(named: "mainCellBackground"))
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath == IndexPath(item: 0, section: 2) && self.tagViewCell.squareData.count > 0 {
            let line = ceil(CGFloat(self.tagViewCell.squareData.count) / CGFloat(rowItemCount))
            return itemH * line
        }
        
        return 44
    }
    
    // MARK: 用户响应方法
    /// 夜间模式切换
    @IBAction func clickedNightModeBtn(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.nightMode = !appDelegate.nightMode
    }
}

// MARK: HWTagsViewCellDelegate 代理
extension MeViewController: HWTagsViewCellDelegate {
    
    func tagsViewCell(view: HWTagsViewCell, didClickedSquare square: HWMeSquare) {
        let urlStr = square.url!
        guard let url = URL(string: urlStr) else {
            // TODO: 更多按钮
            return
        }
        if urlStr.hasPrefix("http") {
            let webVC = HWSquareWebViewController()
            webVC.hidesBottomBarWhenPushed = true
            webVC.url = url
            webVC.navigationItem.title = square.name
            self.navigationController?.pushViewController(webVC, animated: true)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// MARK: HWTagsViewCellDelegate  代理
protocol HWTagsViewCellDelegate: NSObjectProtocol {
    func tagsViewCell(view:HWTagsViewCell, didClickedSquare square:HWMeSquare)
}
// MARK: HWTagsViewCell 自定义Cell
// 最后一个 Cell 的类定义
class HWTagsViewCell: UITableViewCell {
    
    weak var delegate: HWTagsViewCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var squareData = [HWMeSquare]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// UICollectionViewDataSource, UICollectionViewDelegate  代理和数据源
extension HWTagsViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return squareData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kTagCollectionCellKey, for: indexPath) as! HWTagCollectionViewCell
        cell.model = squareData[indexPath.item]
        return cell
    }
    
    // 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tagsViewCell(view: self, didClickedSquare: squareData[indexPath.item])
    }
}

// MARK: UICollectionViewFlowLayout  流布局
class HWTagCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        // Cell 间隙
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        // Cell Size
        itemSize = CGSize.init(width: itemW, height: itemH)
        // 背景色
        collectionView?.backgroundColor = UIColor.hw_lightGray
        // 回弹
        collectionView?.bounces = false
        // 滚动条
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isScrollEnabled = false
    }
}

// MARK: HWTagCollectionViewCell 代理
class HWTagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundView = UIImageView(image: UIImage(named: "mainCellBackground"))
    }
    
    var model: HWMeSquare? {
        didSet {
            updateCellUI()
        }
    }
    private func updateCellUI() {
        tagImageView.image = nil
        tagNameLabel.text = nil
        guard let data = model else { return }
        tagNameLabel.text = data.name
        guard let iconURLStr = data.icon else { return }
        tagImageView.sd_setImage(with: URL(string:iconURLStr))
    }
}
