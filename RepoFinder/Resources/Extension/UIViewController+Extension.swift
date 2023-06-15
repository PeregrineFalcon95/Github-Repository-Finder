//
//  UIViewController+Extension.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import UIKit

extension UIViewController {
    func showAlert(msg: String, title: String = "" ) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
