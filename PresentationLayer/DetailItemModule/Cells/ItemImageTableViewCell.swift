//
//  ItemImageTableViewCell.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import UIKit

final class ItemImageTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let imageInsets: CGFloat = 16
        static let sizeMultiplier: CGFloat = 326/343
        static let priority: Float = 900
    }
    
    // MARK: - Sublayers
    
    private lazy var photoView: UIImageView = {
        $0.cornerSettings()
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // MARK: - Public properties
    
    var imageUrl: String = "" {
        didSet {
            photoView.loadImage(from: URL(string: imageUrl))
        }
    }
    
    // MARK: - Initiaize
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        placePhotoView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init has not been implemented")
    }
}

// MARK: - Place Views Methods

private extension ItemImageTableViewCell {
    
    func placePhotoView() {
        addSubview(photoView)
        photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.imageInsets).isActive = true
        photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.imageInsets).isActive = true
        photoView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.imageInsets).isActive = true
        photoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.imageInsets).isActive = true
        
        let heightConstrint = photoView.heightAnchor.constraint(equalTo: photoView.widthAnchor, multiplier: Constants.sizeMultiplier)
        heightConstrint.priority = UILayoutPriority(Constants.priority)
        heightConstrint.isActive = true
    }
}
