//
//  AppDelegate.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/10.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
    var statusWindow: UIWindow!
    
    private let kNightModeKey = "kNightModeKey"
    var nightMode:Bool = false {
        didSet {
            guard let mode = UserDefaults.standard.value(forKey: kNightModeKey) as? Bool  else {
                UserDefaults.standard.set(nightMode, forKey: kNightModeKey)
                return
            }
            if mode != nightMode {
                UserDefaults.standard.set(nightMode, forKey: kNightModeKey)
            }
        }
    }
    
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Main
        let mainTabBarVC = MainTabBarViewController()
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = mainTabBarVC
        
		// 自定义一个状态栏
		statusWindow = UIWindow(frame: application.statusBarFrame)
        statusWindow.windowLevel = UIWindowLevelAlert
        let gesture = UITapGestureRecognizer(target: self, action: #selector(scrollToTop))
        statusWindow.addGestureRecognizer(gesture)
		// iOS9.0之后如果程序启动完成的那一刻不设置root控制器报错：Application windows are expected to have a root view controller at the end of application launch
		// 但是如果设置延时之后显示，就不会报错
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 2 * NSEC_PER_SEC)) {
            self.statusWindow.isHidden = false
		}
		
        setupNightMode()
        
		setupUI()
        
        window?.makeKeyAndVisible()
		
		return true
	}
    
    func setupNightMode() {
        if let mode = UserDefaults.standard.value(forKey: kNightModeKey) as? Bool {
            nightMode = mode
        } else {
            UserDefaults.standard.set(nightMode, forKey: kNightModeKey)
        }
    }
	
	func setupUI() {
		/// Navi 通用这只
        UINavigationBar.appearance().tintColor = nightMode ? UIColor.hw_drakGray :  UIColor.hw_red
		/// Tab Bar Item 字体
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.hw_gray], for: UIControlState())
		UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.hw_red], for: .selected)
	}
    
    func scrollToTop() {
        let window = UIApplication.shared.keyWindow!
        findScrollViewInView(view: window)
    }
    
    func findScrollViewInView(view: UIView) {
        
        // 递归找view
        for v in view.subviews {
            findScrollViewInView(view: v)
        }
        
        if !view.isKind(of: UIScrollView.self) {
            return
        }
        
        let scrollView = view as! UIScrollView
        // 判断是否可见
        let rect = scrollView.convert(scrollView.bounds, to: nil)
        if !UIScreen.main.bounds.intersects(rect) {
            return
        }
        HWLog("\(scrollView)")
        // UIScrollview 滚动
        var offset = scrollView.contentOffset
        offset.y = -scrollView.contentInset.top
        scrollView.setContentOffset(offset, animated: true)
        
    }
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        switch url.absoluteString {
        case "mod://BDJ_To_Check" :
            break;
        case "mod://BDJ_To_RankingList" :
            break;
        case "mod://BDJ_To_RecentHot" :
            break;
        case "mod://BDJ_To_Mine@dest=1" :
            break;
        case "mod://BDJ_To_Mine@dest=2" :
            break;
        case "mod://BDJ_To_Cate@cate=3#type=0" :
            break;
        case "mod://App_To_SearchUser" :
            break;
        case "mod://App_To_MyVideo" :
            break;
        default:
            break;
        }
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        HWLog("")
        return true
    }
	
}

