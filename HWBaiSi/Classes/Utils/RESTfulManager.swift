//
//  RESTfulManager.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/15.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import Foundation
import AFNetworking
import MJExtension
import SVProgressHUD

class RESTfulManager {
    
    static let sharedInstance = RESTfulManager()
    private var networkingManager: AFHTTPSessionManager!
    private init() {
        let baseURL = URL(string: "http://api.budejie.com/api")
        networkingManager = AFHTTPSessionManager(baseURL: baseURL)
    }
    
    // MARL: 外部方法
    
    func checkNetwork() {
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setStatus("网络不可达")
        SVProgressHUD.show()
        SVProgressHUD.dismiss(withDelay: 3.0)
    }
    
    /// 获取“我”页面的方块类型数据
    func fetchSquareTags(completion:((_ data:[HWMeSquare]?, _ error: Error?) -> Void)?) {
        
        let paras = ["a":"square","c":"topic","client":"iphone"]
        networkingManager.get("api_open.php", parameters: paras, progress: nil, success: { (_, data) in
            
            var res = [HWMeSquare]()
            guard let dict = data as? [String: Any] else {
                completion?(res, nil)
                return
            }
            guard let dictArr = dict["square_list"] else {
                completion?(res, nil)
                return
            }
            res = HWMeSquare.mj_objectArray(withKeyValuesArray: dictArr).copy() as! [HWMeSquare]
            // 去重
            var filterArr = [HWMeSquare]()
            for item in res {
                var diffFlag = true
                for filterItem in filterArr {
                    if (filterItem.url == item.url) {
                        diffFlag = false
                        break
                    }
                }
                if diffFlag {
                    filterArr.append(item)
                }
            }
            completion?(filterArr, nil)
        }) { (_, error) in
            completion?(nil, error)
        }
    }
    
    /// 获取首页的推荐关注数据
    func fetchRecommendTags(completion:((_ data:[HWRecommendTag]?, _ error: Error?) -> Void)?) {

        let paras = ["a":"tag_recommend","action":"sub","c":"topic"]
        networkingManager.get("api_open.php", parameters: paras, progress: nil, success: { (_, data) in
            var res = [HWRecommendTag]()
            res = HWRecommendTag.mj_objectArray(withKeyValuesArray: data).copy() as! [HWRecommendTag]
            completion?(res, nil)
        }) { (_, error) in
            completion?(nil, error)
        }
    }
    
    /// 获取帖子数据
    func fetchTopicData(type:Int, list: String, maxtime:String?, completion:((_ info: [String: Any]?, _ data: [HWTopic]?, _ error: Error?) -> Void)?) -> URLSessionTask? {

        var paras = ["a":"list","c":"data","type":type] as [String : Any]
        if let maxtime = maxtime {
            paras["maxtime"] = maxtime
        }
        
        let task = networkingManager.get("api_open.php", parameters: paras, progress: nil, success: { (_, data) in
            guard let resData = data as? [String: Any] else {
                let error = NSError(domain: "com.tuluobo.error", code: -999, userInfo: [NSLocalizedDescriptionKey : "请求数据错误"])
                completion?(nil, nil, error)
                return
            }
            guard let info = resData["info"] as? [String: Any] else {
                let error = NSError(domain: "com.tuluobo.error", code: -998, userInfo: [NSLocalizedDescriptionKey : "请求数据Info信息错误"])
                completion?(nil, nil, error)
                return
            }
            
            guard let list = resData["list"] as? [[String: Any]] else {
                let error = NSError(domain: "com.tuluobo.error", code: -997, userInfo: [NSLocalizedDescriptionKey : "请求数据List错误"])
                completion?(nil, nil, error)
                return
            }
            let listModels = HWTopic.mj_objectArray(withKeyValuesArray: list).copy() as! [HWTopic]
            completion?(info, listModels, nil)
        }) { (_, error) in
            completion?(nil, nil, error)
        }
        
        return task
    }
}
