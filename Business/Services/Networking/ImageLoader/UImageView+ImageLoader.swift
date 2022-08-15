//
//  UImageView+ImageLoader.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import UIKit

extension UIImageView {

    func loadImage(from url: URL?) {
        guard let url = url else { return }
        
        ImageLoader().loadImage(from: url) { [weak self] result in
            if case let .success(image) = result {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
