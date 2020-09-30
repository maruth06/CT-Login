//
//  UIButton+.swift
//  CT-Login
//
//  Created by Mac Mini 2 on 9/29/20.
//

import Foundation
import UIKit

extension UIView {

    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
    
    func slideUp(duration: TimeInterval = 1.0, completionDelegate: CAAnimationDelegate? = nil) {
        // Create a CATransition animation
        let transition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate = completionDelegate {
            transition.delegate = delegate
        }
        
        // Customize the animation's properties
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(transition, forKey: "slideUpFromBottomTransition")
    }
    
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}
