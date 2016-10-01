//
//  HWCommentViewController.swift
//  HWBaiSi
//
//  Created by WangHao on 2016/10/1.
//  Copyright © 2016年 Tuluobo. All rights reserved.
//

import UIKit

class HWCommentViewController: BaseViewController {
    
    var topic: HWTopic!
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentBarBottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "评论"
        NotificationCenter.default.addObserver(self, selector: #selector(changeTextFieldFrame), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func changeTextFieldFrame(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        if let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval, let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            self.commentBarBottomMargin.constant = kScreenHeight - keyboardFrame.cgRectValue.origin.y
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HWCommentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        
        return cell
    }
}

extension HWCommentViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.commentTextField.resignFirstResponder()
    }
}
