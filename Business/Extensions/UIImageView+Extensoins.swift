//
//  UIImageView+Extensoins.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import UIKit

extension UIImageView {
    
    func cornerSettings() {
        layer.cornerRadius = 12
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
}
