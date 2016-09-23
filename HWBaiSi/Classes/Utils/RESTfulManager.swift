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

class RESTfulManager {
    
    static let sharedInstance = RESTfulManager()
    private var networkingManager: AFHTTPSessionManager!
    private init() {
        let baseURL = URL(string: "http://api.budejie.com/api")
        networkingManager = AFHTTPSessionManager(baseURL: baseURL)
    }
    
    // MARL: 外部方法
    func fetchTags(completion:((_ data:[HWMeSquare]?, _ error: Error?) -> Void)?) {
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
}
