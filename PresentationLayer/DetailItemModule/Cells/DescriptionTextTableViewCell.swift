//
//  DescriptionTextTableViewCell.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import UIKit

final class DescriptionTextTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let sideInsets: CGFloat = 16
        static let verticalInset: CGFloat = 8
        static let textSize: CGFloat = 12
    }
    
    // MARK: - Sublayers
    
    private lazy var descLabel: UILabel = {
        $0.font = UIFont(name: "SFProText-Regular", size: Constants.textSize)
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    // MARK: - Public properties
    
    var descText: String = "" {
        didSet {
            descLabel.text = descText
        }
    }
    
    // MARK: - Initiaize
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        placeLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init has not been implemented")
    }
}

// MARK: - Place Views Methods

private extension DescriptionTextTableViewCell {
    
    func placeLabel() {
        addSubview(descLabel)
        descLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideInsets).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideInsets).isActive = true
        descLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalInset).isActive = true
        descLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalInset).isActive = true
    }
}

