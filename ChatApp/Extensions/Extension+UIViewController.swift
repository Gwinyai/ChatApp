//
//  Extension+UIViewController.swift
//  ChatApp
//
//  Created by Gwinyai Nyatsoka on 24/7/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showLoadingView() {
        let loadingView = LoadingView()
        view.addSubview(loadingView)
        loadingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        loadingView.tag = 20230100
    }
    
    func removeLoadingView() {
        if let loadingView = view.viewWithTag(20230100) {
            loadingView.removeFromSuperview()
        }
    }
    
}
