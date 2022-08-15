//
//  TitleDateTableViewCell.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import UIKit

final class TitleDateTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let sideTitleInset: CGFloat = 16
        static let sideDateInset: CGFloat = 21
        static let titleSize: CGFloat = 16
        static let dateSize: CGFloat = 10
        static let huggingPriority: Float = 251
    }
    
    // MARK: - Sublayers
    
    private lazy var titleLabel: UILabel = {
        $0.font = UIFont(name: "SFProText-Regular", size: Constants.titleSize)
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var dateLabel: UILabel = {
        $0.font = UIFont(name: "SFProText-Regular", size: Constants.dateSize)
        $0.textColor = .systemGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    // MARK: - Public properties
    
    var titleText: String = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var dateText: String = "" {
        didSet {
            dateLabel.text = dateText
        }
    }
    
    // MARK: - Initiaize
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        selectionStyle = .none
        placeLabels()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init has not been implemented")
    }
}

// MARK: - Place Views Methods

private extension TitleDateTableViewCell {
    
    func placeLabels() {
        placeTitleLabel()
        placeDateLabel()
    }
    
    func placeTitleLabel() {
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideTitleInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func placeDateLabel() {
        addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: Constants.sideTitleInset).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideDateInset).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        dateLabel.setContentHuggingPriority(UILayoutPriority(Constants.huggingPriority), for: .horizontal)
    }
}
