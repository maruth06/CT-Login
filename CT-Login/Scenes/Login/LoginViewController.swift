//
//  LoginViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import UIKit
import Combine

class LoginViewController: UIViewController {

    @IBOutlet private weak var bottomConstraints: NSLayoutConstraint!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var togglePasswordButton: UIButton!
    @IBOutlet private weak var loginButton: TransitionButton!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    @IBOutlet private weak var errorUsernameLabel: UILabel!
    @IBOutlet private weak var errorPasswordLabel: UILabel!
    @IBOutlet private weak var loginView: UIView!
    
    private var viewModel : LoginViewModel!
    private var subscriptions = Set<AnyCancellable>()

    class func instantiate() -> UIViewController {
        let viewController = LoginViewController()
        viewController.viewModel = LoginViewModel()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNotificationObservers()
        configureViews()
        
        userNameTextField.text = "mockUser"
        passwordTextField.text = "helloWorld"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureBindings()
    }

    private func configureViews() {
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.returnKeyType = .next
        passwordTextField.returnKeyType = .done
        
        userNameTextField.addBorder(width: 1, color: .darkGray)
        passwordTextField.addBorder(width: 1, color: .darkGray)
    }
    
    private func configureBindings() {
        viewModel.$isLoginSuccess.sink { (isSuccess) in
            if isSuccess {
                self.showUserDetailsView()
            } else {
                self.errorMessageLabel.text = "Invalid username or password."
                self.loginButton.shake()
            }
        }.store(in: &subscriptions)
        
        viewModel.$showPassword.sink { (isShow) in
            let title = isShow ? "HIDE" : "SHOW"
            self.togglePasswordButton.setTitle(title, for: .normal)
            self.passwordTextField.isSecureTextEntry = !isShow
        }.store(in: &subscriptions)
        
        viewModel.$isUserNameEmpty.sink { (isEmpty) in
            if isEmpty {
                self.userNameTextField.addBorder(width: 1, color: .red)
                self.errorUsernameLabel.text = "Username is required."
            } else {
                self.userNameTextField.addBorder(width: 1, color: .darkGray)
                self.errorUsernameLabel.text = ""
            }
        }.store(in: &subscriptions)
        
        viewModel.$isPasswordEmpty.sink { (isEmpty) in
            if isEmpty {
                self.passwordTextField.addBorder(width: 1, color: .red)
                self.errorPasswordLabel.text = "Password is required."
            } else {
                self.passwordTextField.addBorder(width: 1, color: .darkGray)
                self.errorPasswordLabel.text = ""
            }
        }.store(in: &subscriptions)
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardNotification(notification:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil)
    }
    
    // MARK: - Navigation Methods
    private func showUserDetailsView() {
        self.loginButton.stopAnimation(animationStyle: .expand, completion: {
            let viewController = SplitViewController.instantiate()
            self.present(viewController, animated: true, completion: nil)
        })
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
    
    @IBAction func onTappedLoginButton(_ sender: Any) {
        self.loginButton.startAnimation()
        self.errorMessageLabel.text = nil
        self.viewModel.validateUserCredentials(self.userNameTextField.text,
                                               self.passwordTextField.text)
    }
    
    @IBAction func onTappedTogglePasswordButton(_ sender: Any) {
        viewModel.showPassword = !viewModel.showPassword
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .next:
            passwordTextField.becomeFirstResponder()
            break
        case .done:
            viewModel.validateUserCredentials(userNameTextField.text,
                                              passwordTextField.text)
            break
        default: break
        }
        return true
    }
}
