//
//  LoaderButton.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 04.09.2022.
//

import UIKit

class LoaderButton: UIButton {
    // MARK: - Constants
    
    private enum Constants {
        static let loaderSize: CGFloat = 16
        static let duration: CGFloat = 2
    }
    
    // MARK: - Sublayers
    
    private lazy var loader: UIImageView = {
        $0.image = UIImage(named: "loader")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (UIImageView())
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        placeLoader()
        loader.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Placement

private extension LoaderButton {
    
    func placeLoader() {
        addSubview(loader)
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.widthAnchor.constraint(equalToConstant: Constants.loaderSize).isActive = true
        loader.heightAnchor.constraint(equalToConstant: Constants.loaderSize).isActive = true
    }
}

// MARK: - Public methods

extension LoaderButton {
    
    func startLoader() {
        bringSubviewToFront(loader)
        loader.isHidden = false
        setTitleColor(.black, for: .normal)
        loader.rotate(duration: Constants.duration)
    }
    
    func stopLoader() {
        loader.isHidden = true
        loader.stopRotating()
        setTitleColor(.white, for: .normal)
    }
}
