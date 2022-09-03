//
//  PaddingTextField.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 21.08.2022.
//

import UIKit

class PaddingTextField: UITextField {
    // MARK: - Constants
    
    private enum Constants {
        static let padding = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }

    // MARK: - LifeCycle

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }

    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -Constants.padding.right, dy: 0)
    }
}
