//
//  EssenceViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

fileprivate let kHWTableCollectionViewCellKey = "collectionCell"

class EssenceViewController: BaseViewController {

    var tableType = [HWContentType]()
    var tableItem = [IndexPath: HWTableCollectionViewCell]()
    private var currentTitleBtn: UIButton! {
        didSet {
            oldValue?.isSelected = false
            currentTitleBtn?.isSelected = true
        }
    }

    @IBOutlet weak var allTypeTitleBtn: UIButton!
    @IBOutlet weak var tableCollectionView: UICollectionView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
		self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        currentTitleBtn = allTypeTitleBtn
        
        loadData()
	}
    
    func loadData() {
        let type = [["title":"全部","dataURL":"1"],
                    ["title":"视频","dataURL":"2"],
                    ["title":"声音","dataURL":"3"],
                    ["title":"图片","dataURL":"4"],
                    ["title":"段子","dataURL":"5"]]
        tableType = HWContentType.mutilInit(arr: type)
    }
    
    // 点击title事件
    @IBAction func clickedTitleBtn(_ sender: UIButton) {
        currentTitleBtn = sender
        let tag = sender.tag
        tableCollectionView.scrollToItem(at: IndexPath(item: tag, section: 0), at: .centeredHorizontally, animated: true)
    }
    
}

// MARK: collection的代理和数据源
extension EssenceViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableType.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        for i in 0 ..< tableType.count {
            let iPath = IndexPath(item: i, section: 0)
            guard let _ = tableItem[iPath] else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHWTableCollectionViewCellKey, for: iPath) as! HWTableCollectionViewCell
                cell.tableView.model = tableType[i]
                tableItem[iPath] = cell
                continue
            }
        }        
        // 载入table数据
        return tableItem[indexPath]!
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            // TODO: 设置按钮
    }
}

// MARK: - 自定义布局
class HWTableFlowLayout: UICollectionViewFlowLayout {
    // 准备布局
    override func prepare() {
        // 1.设置每一个 cell 的尺寸
        itemSize = UIScreen.main.bounds.size
        // 2.设置cell之间的间隙
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        // 3.设置滚动方向
        scrollDirection = .horizontal
        // 4.设置分页
        collectionView?.isPagingEnabled = true
        // 5.禁用回弹
        collectionView?.bounces = true
        // 6.去除滚动条
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}

