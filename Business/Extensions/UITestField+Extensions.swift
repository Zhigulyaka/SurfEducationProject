//
//  UITestField+Extensions.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 21.08.2022.
//

import UIKit

enum RoundCornersType {
    case all
    case top
    case bottom
}

extension UITextField {
    // MARK: - Сonstants
    
    private enum Constants {
        static let separatorHeight: CGFloat = 1
    }
    
    // MARK: - Layouts
    
    func addSeparator() {
        let separator = UIView(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: Constants.separatorHeight))
        separator.backgroundColor = .placeholderText
        addSubview(separator)
    }
    
    func addCorners(type: RoundCornersType, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        switch type {
        case .all:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .top:
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom:
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
}

// MARK: - Editing

extension UITextField {
    
    func phoneFormat(phone: String) -> String {
        var numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if numbers.first == "7" {
            numbers.removeFirst()
        }
        var result = ""
        var index = numbers.startIndex
        let mask = "+7 (XXX) XXX XX XX"

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])

                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
}
