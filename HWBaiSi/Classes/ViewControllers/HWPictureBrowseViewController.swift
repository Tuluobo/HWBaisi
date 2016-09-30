//
//  HWPictureBrowseViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/9/29.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import Photos
import SVProgressHUD

class HWPictureBrowseViewController: BaseViewController {

    var model: HWTopic!
    fileprivate var imageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageContainerView.delegate = self
        setupImage()
    }
    
    private func setupImage() {
        
        self.imageView = UIImageView()
        self.imageView.sd_setImage(with: URL(string:model.image1!)) { (image, error, _, _) in
            guard let _ = image else {
                HWLog("\(error!)")
                return
            }
            self.saveButton.isEnabled = true
        }
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
        // 0.请求权限
        self.requestAuth {
            guard let image = self.imageView.image else {
                SVProgressHUD.showError(withStatus: "图片获取出现问题")
                return
            }
            // 1.获取相册
            guard let assetCollection = self.getAlbum() else {
                SVProgressHUD.showError(withStatus: "相册创建失败")
                return
            }
            // 2.保存到系统相册
            var assetIdentifier = ""
            PHPhotoLibrary.shared().performChanges({ 
                let assetCreateRequest = PHAssetCreationRequest.creationRequestForAsset(from: image)
                assetIdentifier = assetCreateRequest.placeholderForCreatedAsset?.localIdentifier ?? ""
            }, completionHandler: { (success, error) in
                if success == false {
                    self.showError(info: "图片保存失败")
                    return
                }
                // 3.关联图片到自己的相册
                PHPhotoLibrary.shared().performChanges({
                   let asset = PHAsset.fetchAssets(withLocalIdentifiers: [assetIdentifier], options: nil).firstObject!
                    PHAssetCollectionChangeRequest(for: assetCollection)!.addAssets(NSArray(array: [asset]))
                    }, completionHandler: { (success, error) in
                        HWLog("34：\(Thread.current)")
                        if success == false {
                            self.showError(info: "图片关联失败")
                        } else {
                            self.showSuccess(info: "图片保存成功")
                        }
                })
            })

        }
    }
    
    /// 请求权限
    private func requestAuth(completed:(()->Void)?) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            completed?()
        case .denied:
            SVProgressHUD.showError(withStatus: "需要在设置中开启相册权限")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .authorized {
                    completed?()
                } else {
                    SVProgressHUD.showError(withStatus: "相册访问失败")
                }
            })
        case .restricted:
            SVProgressHUD.showError(withStatus: "系统不允许用户访问相册")
        }
    }
    
    /// 获得相册
    private func getAlbum() -> PHAssetCollection? {
        // 0.检查是否存在相册
        var assetCollection: PHAssetCollection?
        let existCollections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        for i in 0..<existCollections.count {
            let collection = existCollections.object(at: i)
            if collection.localizedTitle == kPhotoCollectionTitle {
                assetCollection = collection
                break
            }
        }
        // 1.创建自己的相册
        var assetCollectionIdentifier = ""
        if assetCollection == nil {
            do {
                try PHPhotoLibrary.shared().performChangesAndWait {
                    let collectionCreateRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: kPhotoCollectionTitle)
                    assetCollectionIdentifier = collectionCreateRequest.placeholderForCreatedAssetCollection.localIdentifier
                }
            } catch let error {
                HWLog("error:\(error)")
                return nil
            }
            assetCollection = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [assetCollectionIdentifier], options: nil).firstObject
        }
        return assetCollection
    }
    
    /// 提示错误
    private func showError(info: String) {
        DispatchQueue.main.async {
            SVProgressHUD.showError(withStatus: info)
        }
    }
    
    /// 提示成功
    private func showSuccess(info: String) {
        DispatchQueue.main.async {
            SVProgressHUD.showSuccess(withStatus: info)
        }
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
