//
//  PlugSearchView.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 17.08.2022.
//

import UIKit

// MARK: - PlugMode

enum PlugVeiwMode {
    case input
    case notFound
    
    var title: String {
        switch self {
        case .input:
            return "Введите ваш запрос"
        case .notFound:
            return "По этому запросу нет результатов,\nпопробуйте другой запрос"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .input:
            return UIImage(named: "inputRequest")
        case .notFound:
            return UIImage(named: "searchNotFound")
        }
    }
}

final class PlugSearchView: UIView {
    // MARK: - Constants
    
    private enum Constants {
        static let textSize: CGFloat = 14
        static let imageSize: CGFloat = 28
        static let betweenInset: CGFloat = 14.25
        static let sideInsets: CGFloat = 16
    }
    
    // MARK: - Properties
    
    var mode: PlugVeiwMode = .input {
        didSet {
            imageView.image = mode.image
            label.text = mode.title
        }
    }
    
    // MARK: - Subviews
    
    private lazy var imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var label: UILabel = {
        $0.font = UIFont(name: "SFProText-Regular", size: Constants.textSize)
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.textColor = .systemGray
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    // MARK: - Initialize
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init() {
        self.init(frame: .zero)
        
        placeViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init has not been implemented")
    }
}

// MARK: - Layout

private extension PlugSearchView {
    
    private func placeViews() {
        backgroundColor = .clear
        
        placeImageVeiw()
        placeLabel()
    }
    
    private func placeImageVeiw() {
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func placeLabel() {
        addSubview(label)
        
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sideInsets).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.sideInsets).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.betweenInset).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

// MARK: - Utilts

extension PlugSearchView {
    func setHidden(_ isHidden: Bool) {
        if isHidden {
            self.isHidden = isHidden
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.isHidden = isHidden
        }
    }
}

