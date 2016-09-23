//
//  HWSquareWebViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/22.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import WebKit

fileprivate let kWkWebViewProgressObserverKey = "estimatedProgress"

class HWSquareWebViewController: BaseViewController {

    var url: URL?
    
    fileprivate var barGoBack:UIBarButtonItem!
    fileprivate var barGoForward:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barFlexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        barGoBack = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.rewind, target: self, action: #selector(goBack))
        barGoForward = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fastForward, target: self, action: #selector(goForward))
        barGoBack.isEnabled = false
        barGoForward.isEnabled = false
        
        let refreshBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(refresh))
        self.toolbarItems = [
            barGoBack,
            barGoForward,
            barFlexibleSpace,
            refreshBtn
        ]
        wkWebView.addObserver(self, forKeyPath: kWkWebViewProgressObserverKey, options:NSKeyValueObservingOptions.new, context: nil)
        requestWeb()
    }
    deinit {
        wkWebView.removeObserver(self, forKeyPath: kWkWebViewProgressObserverKey)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isToolbarHidden = true
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == kWkWebViewProgressObserverKey {
            
        }
    }
    
    // MARK: 内部方法
    /// webView 网络请求
    private func requestWeb() {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        wkWebView.load(request)
    }
    /// 返回
    @objc private func goBack() {
        self.wkWebView.goBack()
    }
    /// 前进
    @objc private func goForward() {
        self.wkWebView.goForward()
    }
    /// 刷新
    @objc private func refresh() {
        self.wkWebView.reload()
    }
    
    // MARK: 懒加载
    lazy fileprivate var wkWebView: WKWebView = {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: self.view.bounds, configuration: config)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        return webView
    }()

}

// MARK: WKNavigationDelegate
extension HWSquareWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.barGoBack.isEnabled = self.wkWebView.canGoBack
        self.barGoForward.isEnabled = self.wkWebView.canGoForward
    }
}
