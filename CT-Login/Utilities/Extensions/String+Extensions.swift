//
//  String+Extensions.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/30/20.
//

import Foundation
import UIKit

extension String {
    
    var toCGFloat: CGFloat {
        guard let number = NumberFormatter().number(from: self) else { return 0.0 }
        return CGFloat(truncating: number)
    }
}
