//
//  UIViewController+Kit.swift
//  QuizApp
//
//  Created by Priyanshi Bhikadiya on 2024-03-24.
//  Copyright © 2024 Priyanshi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func pushVc(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func navigatePopToViewController(vc: Any) {
        for element in (navigationController?.viewControllers ?? []) as Array where "\(type(of: element)).Type" == "\(type(of: vc))" {
            self.navigationController?.popToViewController(element, animated: true)
            break
        }
    }
    
    func navigatePopToRootViewController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func navigateBackViewController(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func presentVC(_ style: UIModalPresentationStyle = .overFullScreen, vc: UIViewController) {
        vc.modalPresentationStyle = style
        self.navigationController?.present(vc, animated: true)
    }
    
    @objc func actionDismiss() {
        self.dismiss(animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    @objc func btnActionBack() {
        self.navigateBackViewController()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.presentVC(vc: alert)
    }
    
}

extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
