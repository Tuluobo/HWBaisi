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

    var tableItem = [String]()

	override func viewDidLoad() {
		super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
		self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        // TODO: 添加数据
        tableItem = ["t1","t2","t3","t4","t5","t6"]
	}
    
}

// MARK: collection的代理和数据源
extension EssenceViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableItem.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHWTableCollectionViewCellKey, for: indexPath) as! HWTableCollectionViewCell
        // TODO: Cell
        return cell
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

