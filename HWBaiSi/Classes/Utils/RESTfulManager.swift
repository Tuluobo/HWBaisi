//
//  RESTfulManager.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/15.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import Foundation
import AFNetworking

class RESTfulManager {
    
    static let sharedInstance = RESTfulManager()
    private var networkingManager: AFHTTPSessionManager!
    private init() {
        let baseURL = URL(string: "http://api.budejie.com/api")
        networkingManager = AFHTTPSessionManager(baseURL: baseURL)
    }
    
    // MARL: 外部方法
    func fetchTags(completion:((_ data:[[String: Any]]?, _ error: Error?) -> Void)?) {
        let paras = ["a":"square","c":"topic"]
        networkingManager.get("api_open.php", parameters: paras, progress: nil, success: { (_, data) in
            
            HWLog("\(data)")
            
            var res = [[String: Any]]()
            guard let dict = data as? [String: Any] else {
                completion?(res, nil)
                return
            }
            guard let dictArr = dict["square_list"] as? [[String: Any]] else {
                completion?(res, nil)
                return
            }
            res = dictArr
            completion?(res, nil)
        }) { (_, error) in
            completion?(nil, error)
        }
    }
}
