//
//  HWTopicCollectionViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

fileprivate let kHWTableCollectionViewCellKey = "collectionCell"

class HWTopicCollectionViewController: BaseViewController {

    var contentModels = [HWContent]()
    fileprivate var currentTitleBtn: UIButton! {
        didSet {
            oldValue?.isSelected = false
            currentTitleBtn?.isSelected = true
        }
    }

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var tableCollectionView: UICollectionView!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
		self.navigationItem.titleView = UIImageView(image: UIImage(named: "MainTitle"))
        // 加载数据
        loadData()
        currentTitleBtn = titleView.viewWithTag(1) as! UIButton
        currentTitleBtn.sizeToFit()
        currentTitleBtn.titleLabel?.sizeToFit()
        self.titleView.addSubview(indicatorView)
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        clickedTitleBtn(currentTitleBtn)
    }
    
    func loadData() {
        var type = [["title":"全部","viewController":HWAllViewController()],
                    ["title":"视频","viewController":HWVideoViewController()],
                    ["title":"声音","viewController":HWVoiceViewController()],
                    ["title":"图片","viewController":HWPictureViewController()],
                    ["title":"段子","viewController":HWWordViewController()]]
        if let index = self.tabBarController?.selectedIndex, index == 1 {
            type = [["title":"全部","viewController":HWNewAllViewController()],
                    ["title":"视频","viewController":HWNewVideoViewController()],
                    ["title":"声音","viewController":HWNewVoiceViewController()],
                    ["title":"图片","viewController":HWNewPictureViewController()],
                    ["title":"段子","viewController":HWNewWordViewController()]]
        }
        contentModels = HWContent.mutilInit(arr: type)
    }
    
    // 点击title事件
    @IBAction func clickedTitleBtn(_ sender: UIButton) {
        let tag = sender.tag - 1
        tableCollectionView.scrollToItem(at: IndexPath(item: tag, section: 0), at: .centeredHorizontally, animated: true)
        currentTitleBtn = sender
        UIView.animate(withDuration: 0.25) {
            self.indicatorView.frame.size.width = self.currentTitleBtn.titleLabel?.frame.size.width ?? 0
            self.indicatorView.center.x = self.currentTitleBtn.center.x
        }
    }
    
    // MARK: 懒加载成员
    /// 按钮下的指示View
    lazy fileprivate var indicatorView: UIView = {
        // 设置UI
        let indicatorH: CGFloat = 2.0;
        let view = UIView()
        view.center.x = self.currentTitleBtn.center.x
        view.frame.origin.y = self.currentTitleBtn.frame.size.height + 1
        view.frame.size = CGSize(width: self.currentTitleBtn.titleLabel?.frame.size.width ?? 0, height: indicatorH)
        view.backgroundColor = self.currentTitleBtn.currentTitleColor
        return view
    }()

}

// MARK: collection的代理和数据源
extension HWTopicCollectionViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHWTableCollectionViewCellKey, for: indexPath)
        // TODO: 载入table数据
        let childView = contentModels[indexPath.item].viewController.view
        cell.addSubview(childView!)
        return cell
    }
    
    // scrollView 代理方法，手动滚动scrollview结束
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        clickedTitleBtn(titleView.viewWithTag(index + 1) as! UIButton)
    }
    
}

// MARK: 内容控制器Model
class HWContent: NSObject {
    
    var title: String!
    var viewController: UIViewController!
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    class func mutilInit(arr: [[String: Any]]) -> [HWContent] {
        var type = [HWContent]()
        for item in arr {
            type.append(HWContent(dict: item))
        }
        return type
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
