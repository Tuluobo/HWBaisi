//
//  HWPictureBrowseViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/29.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
//import Photos

class HWPictureBrowseViewController: BaseViewController {

    var model: HWTopic!
    fileprivate var imageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageContainerView.delegate = self
        setupImage()
    }
    
    private func setupImage() {
        
        self.imageView = UIImageView()
        self.imageView.sd_setImage(with: URL(string:model.image1!))
        imageContainerView.addSubview(self.imageView)
        
        let height = CGFloat(model.height!.doubleValue) * kScreenWidth / CGFloat(model.width!.doubleValue)
        self.imageView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: height)
        imageContainerView.contentSize = CGSize(width: kScreenWidth, height: height)
        // 居中
        if(height < kScreenHeight) {
             self.imageView.frame.origin.y = (kScreenHeight - height) / 2.0
        }
        
        // 缩放比例
        let scale =  CGFloat(model.width!.doubleValue) / imageView.frame.size.width
        if (scale > 1.0) {
            imageContainerView.maximumZoomScale = scale
        }
    }

    @IBAction func clickedCloseBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedSaveBtn() {
    
    }
}

// MARK: - UIScrollViewDelegate
extension HWPictureBrowseViewController: UIScrollViewDelegate {
    /**
     *  返回一个scrollView的子控件进行缩放
     */
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
