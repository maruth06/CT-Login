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
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
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
              let detailViewController = lastViewController.viewControllers.first as? DetailsViewController else { fatalError() }
        masterViewController.setDelegate(detailViewController)
    }
}
