//
//  UIView+Extensions.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 04.09.2022.
//

import UIKit

extension UIView {
    // MARK: - Constants
    
    private enum Conatants {
        static let count: CGFloat = 2
        static let kRotationAnimationKey = "rotationanimationkey"
    }
    
    // MARK: - Public methods

    func rotate(duration: Double) {
        if layer.animation(forKey: Conatants.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Double.pi * Conatants.count
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity

            layer.add(rotationAnimation, forKey: Conatants.kRotationAnimationKey)
        }
    }

    func stopRotating() {
        if layer.animation(forKey: Conatants.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: Conatants.kRotationAnimationKey)
        }
    }
}
