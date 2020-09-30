//
//  UserTableViewController.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import UIKit

class UserTableViewController: UITableViewController {

    class func instantiate() -> UITableViewController {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let tableViewController = storyboard.instantiateViewController(identifier: "UserTableViewController") as! UserTableViewController
        return tableViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
