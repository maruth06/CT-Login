//
//  UIViewController+Extensions.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import UIKit

extension UIViewController {
    
    func showNetworkError(_ error: ErrorModel) {
        let statusCode = error.statusCode == nil ? "" : " - \(error.statusCode!)"
        let alertController = UIAlertController(title: "Error\(statusCode)",
                                                message: error.message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
