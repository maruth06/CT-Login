//
//  SplitViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 10/1/20.
//

import UIKit

class SplitViewController: UISplitViewController {

    class func instantiate() -> UISplitViewController {
        let viewController = SplitViewController.instantiate(fromStoryboard: .Details)
        viewController.preferredDisplayMode = .oneOverSecondary
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        
        guard let leftNavController = self.viewControllers.first as? UINavigationController,
              let masterViewController = leftNavController.viewControllers.first as? UserTableViewController,
              let lastViewController = self.viewControllers.last as? UINavigationController,
              let detailViewController = lastViewController.viewControllers.first as? DetailsViewController else { return }
        masterViewController.setDelegate(detailViewController)
    }
}

extension SplitViewController : UIViewControllerTransitioningDelegate {

    open override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return .fullScreen
        }
        set {}
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransition(transitionDuration: 0.5, startingAlpha: 0.8)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeTransition(transitionDuration: 0.5, startingAlpha: 0.8)
    }
}
