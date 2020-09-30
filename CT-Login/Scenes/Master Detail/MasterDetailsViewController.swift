//
//  MasterDetailsViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import UIKit

class MasterDetailsViewController: UISplitViewController {

    class func instantiate() -> UISplitViewController {
        let viewController = MasterDetailsViewController.instantiate(fromStoryboard: .Details)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

}
