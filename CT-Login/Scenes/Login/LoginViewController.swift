//
//  LoginViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var bottomConstraints: NSLayoutConstraint!
    @IBOutlet private weak var userNameTextField: MaterialTextField!
    @IBOutlet private weak var passwordTextField: MaterialTextField!
    
    class func instantiate() -> UIViewController {
        let viewController = LoginViewController()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotificationObservers()
    }

    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardNotification(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    // MARK: - Action Methods
    @objc private func keyboardNotification(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let endFrameY = endFrame.origin.y
        let keyboardAnimationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        if endFrameY >= UIScreen.main.bounds.size.height {
            self.bottomConstraints.constant = 16
        } else {
            self.bottomConstraints.constant = (endFrame.size.height - view.safeAreaInsets.bottom) + 8
        }
        UIView.animate(withDuration: keyboardAnimationDuration,
                       delay: TimeInterval(0),
                       options: animationCurve,
                       animations: { if let view = self.view { view.layoutIfNeeded() } },
                       completion: nil)
    }
}
