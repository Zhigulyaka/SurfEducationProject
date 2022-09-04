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
        static let showButtonSize: CGFloat = 21
    }

    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let clearButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: Constants.showButtonSize, height: Constants.showButtonSize)))
        clearButton.setImage(UIImage(named: "showPassword")?.withTintColor(.placeholderText), for: .normal)

        rightView = clearButton
        clearButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)

        clearButtonMode = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.padding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.rightViewRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -Constants.padding.right, dy: 0)
    }
}

// MARK: - Actions

private extension PaddingTextField {
    
    @objc
    func showButtonTapped() {
        isSecureTextEntry = !isSecureTextEntry
        for subview in subviews {
            if let button = subview as? UIButton {
                let imageName = isSecureTextEntry ? "showPassword" : "hidePassword"
                button.setImage(UIImage(named: imageName)?.withTintColor(.placeholderText), for: .normal)
            }
        }
    }
}
