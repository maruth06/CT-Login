//
//  UIViewController+Extensions.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import UIKit

extension UIViewController {
    
    // MARK: - UIStoryboard
    class var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate(fromStoryboard storyboard: UIStoryboard.Storyboard) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
    
    // MARK: - UINib
    
    private static func nib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
    
    public class func fromNib() -> Self {
        return nib()
    }
    
    func showNetworkError(_ error: ErrorModel) {
        let statusCode = error.statusCode == nil ? "" : " - \(error.statusCode!)"
        let alertController = UIAlertController(title: "Error\(statusCode)",
                                                message: error.message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var window: UIWindow? {
        if #available(iOS 13, *) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let delegate = windowScene.delegate as? SceneDelegate, let window = delegate.window else { return nil }
                   return window
        }
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window else { return nil }
        return window
    }
}
