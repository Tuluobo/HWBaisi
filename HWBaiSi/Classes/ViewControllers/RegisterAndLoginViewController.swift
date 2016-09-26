//
//  RegisterAndLoginViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/14.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class RegisterAndLoginViewController: BaseViewController {
    
    var isLoginVC = true
    
    // Center Constraints
    @IBOutlet weak var loginContainerCenterCons: NSLayoutConstraint!
    // Login TextField
    @IBOutlet weak var loginAccountTF: LoginRegisterTextField!
    @IBOutlet weak var loginPasswordTF: LoginRegisterTextField!
    // Register TextField
    @IBOutlet weak var registerAccountTF: LoginRegisterTextField!
    @IBOutlet weak var registerPasswordTF: LoginRegisterTextField!
    // Btn
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    // 重写导航栏风格
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // 按钮的圆角
        loginBtn.layer.cornerRadius = 6.0
        registerBtn.layer.cornerRadius = 6.0
    }

    // MARK: 用户响应方法
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func clickedCloseBtn() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickedSwitchRegisterAndLoginBtn(sender:UIButton) {
        self.view.endEditing(true)
        isLoginVC = !isLoginVC
        if isLoginVC {
            // 登录输入
            self.loginContainerCenterCons.constant = 0
            sender.setTitle("注册帐号", for: .normal)
            UIView.animate(withDuration: 0.2, animations: { 
                self.view.layer.layoutIfNeeded()
                })
        } else {
            // 注册输入
            self.loginContainerCenterCons.constant = 0 - UIScreen.main.bounds.size.width
            sender.setTitle("已有帐号，去登录", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layer.layoutIfNeeded()
                })
        }
    }
    
    @IBAction func clickedLoginAndRegisterBtn() {
        if isLoginVC {
            guard let account = self.loginAccountTF.text else {
                HWLog("account 不能为空")
                return
            }
            guard let password = self.loginPasswordTF.text else {
                HWLog("password 不能为空")
                return
            }
            login(account: account,password: password)
        } else {
            guard let account = self.registerAccountTF.text else {
                HWLog("account 不能为空")
                return
            }
            guard let password = self.registerPasswordTF.text else {
                HWLog("password 不能为空")
                return
            }
            register(account: account,password: password)
        }
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
    
    // MARK: 内部方法
    private func login(account:String, password: String) {
        HWLog("Login:::account = \(account),password = \(password)")
    }
    private func register(account:String, password: String) {
        HWLog("Register:::account = \(account),password = \(password)")
    }
}

// MARK: Class LoginRegisterTextField 
class LoginRegisterTextField: UITextField, UITextFieldDelegate {
    
    override func awakeFromNib() {
        self.tintColor = UIColor.white
        self.textColor = UIColor.white
        self.delegate = self
        self.hw_placeholderColor = UIColor.gray
    }
    
    override func becomeFirstResponder() -> Bool {
        self.hw_placeholderColor = UIColor.white
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        self.hw_placeholderColor = UIColor.gray
        return super.resignFirstResponder()
    }
}
