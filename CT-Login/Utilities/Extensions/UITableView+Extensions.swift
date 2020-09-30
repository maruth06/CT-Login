//
//  UITableView+Extensions.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation
import UIKit

extension UITableView {
    func register(viewClass: UITableViewCell.Type) {
        self.register(viewClass, forCellReuseIdentifier: viewClass.identifier)
    }
    
    func register(nib: UITableViewCell.Type) {
        self.register(nib.nib, forCellReuseIdentifier: nib.identifier)
    }
    
    func register(viewClass: [UITableViewCell.Type]) {
        viewClass.forEach { (cell) in
            self.register(viewClass: cell)
        }
    }
    
    func register(nib: [UITableViewCell.Type]) {
        nib.forEach { (cell) in
            self.register(nib: cell)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        return dequeueReusableCell(withIdentifier: T.identifier) as! T
    }
}

extension UITableViewCell {
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    var identifier: String {
        return String(describing: self)
    }
}

