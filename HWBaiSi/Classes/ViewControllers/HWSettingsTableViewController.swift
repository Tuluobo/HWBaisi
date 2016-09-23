//
//  HWSettingsTableViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 16/9/23.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit
import SVProgressHUD

class HWSettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(item: 1, section: 0) {
            // 确认 Alert
            let alertVC = UIAlertController(title: "确认删除缓存", message: "您确认要删除缓存？", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
                self.tableView.deselectRow(at: indexPath, animated: false)
            }))
            alertVC.addAction(UIAlertAction(title: "确认", style: .default, handler:{ (_) in
                SVProgressHUD.show(withStatus: "正在删除缓存...")
                SVProgressHUD.setDefaultStyle(.light)
                SVProgressHUD.setDefaultMaskType(.black)
                // 清理缓存
                DispatchQueue.global().async {
                    self.deleteCache()
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.tableView.reloadData()
                    }
                }
            }))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(item: 1, section: 0) {
            cell.detailTextLabel?.text = "正在计算缓存大小..."
            cell.isUserInteractionEnabled = false
            let accessActivity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            accessActivity.hidesWhenStopped = true
            cell.accessoryView = accessActivity
            accessActivity.startAnimating()
            // 计算缓存
            weak var weakSelf = self
            weak var weakCell = cell
            DispatchQueue.global().async {
                let sizeStr = weakSelf?.getDiskCacheSize()
                if weakCell == nil {
                    return
                }
                DispatchQueue.main.async {
                    accessActivity.stopAnimating()
                    weakCell?.isUserInteractionEnabled = true
                    weakCell?.accessoryView = nil
                    weakCell?.accessoryType = .disclosureIndicator
                    weakCell?.detailTextLabel?.text = sizeStr
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension HWSettingsTableViewController {
    
    // MARK: 计算缓存
    func getDiskCacheSize()  -> String {
        let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last
        let size = calcSize(path: cacheDir!)
        return humanReadableStringFromBytes(byteCount: size)
    }
    
    func calcSize(path: String) -> UInt64 {
        var fileSize: UInt64 = 0
        guard let contents = FileManager.default.subpaths(atPath: path) else {
            return fileSize
        }
        for item in contents {
            let fullPath = path.appendingFormat("/%@", item)
            let attributte = try! FileManager.default.attributesOfItem(atPath: fullPath)
            if (attributte[FileAttributeKey.type] as! FileAttributeType) == FileAttributeType.typeRegular {
                fileSize += (attributte[FileAttributeKey.size] as! NSNumber).uint64Value
            }
        }
        return fileSize
    }
    
    func humanReadableStringFromBytes(byteCount: UInt64) -> String {
        var numberOfBytes = Double(byteCount)
        var multiplyFactor = 0
        var tokens = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
        while numberOfBytes > 1024 {
            numberOfBytes /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", numberOfBytes, tokens[multiplyFactor])
    }
    
    // MAR: 清理缓存
    func deleteCache() {
        let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last
        guard let contents = FileManager.default.subpaths(atPath: cacheDir!) else {
            return
        }
        for item in contents {
            let fullPath = cacheDir!.appendingFormat("/%@", item)
            try? FileManager.default.removeItem(atPath: fullPath)
        }
    }
}
