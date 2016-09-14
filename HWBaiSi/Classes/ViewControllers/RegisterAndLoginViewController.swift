//
//  RegisterAndLoginViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/14.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class RegisterAndLoginViewController: BaseViewController {    
    
    @IBOutlet weak var loginContainerView: UIView!
    @IBOutlet weak var loginBtn: UIButton!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()

        loginContainerView.layer.cornerRadius = 8.0
        loginBtn.layer.cornerRadius = 4.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: 外部方法
    
    @IBAction func clickedCloseBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedSwitchRegisterAndLoginBtn() {
        HWLog("")
    }
    
    @IBAction func clickedLoginBtn() {
        HWLog("")
    }
    
    @IBAction func clickedForgetPwdBtn() {
        HWLog("")
    }
    
    @IBAction func clickedWeiboLoginBtn() {
        HWLog("")
        
    }
    
    @IBAction func clickedQQLoginBtn() {
        HWLog("")
        
    }
    
    @IBAction func clickedTencentWeiboLoginBtn() {
        HWLog("")
    }
}
