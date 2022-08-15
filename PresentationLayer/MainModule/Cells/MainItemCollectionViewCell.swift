//
//  MainItemCollectionViewCell.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 11.08.2022.
//

import Foundation
import UIKit

final class MainItemCollectionViewCell: UICollectionViewCell {
     // MARK: - Handlers
     
     public var didFavouriteTapped: ((Bool) -> Void)?
     
     // MARK: - Constants
     
     private enum Constants {
          static let fillHeartImage = UIImage(named: "fillHeart")
          static let emptyHeartImage = UIImage(named: "emptyHeart")
          static let buttonInsets: CGFloat = 10
          static let buttonHeight: CGFloat = 20
          static let buttonWigth: CGFloat = 21
          static let titleTopInset: CGFloat = 8
          static let imageBottomInset: CGFloat = 21
          static let textSize: CGFloat = 12
          static let duration: CGFloat = 0.2
          static let transformScale: CGFloat = 0.98
     }
     
     // MARK: - Subviews
     
     private lazy var imageView: UIImageView = {
          $0.cornerSettings()
          $0.translatesAutoresizingMaskIntoConstraints = false
          return $0
     } (UIImageView())
     
     private lazy var titleLabel: UILabel = {
          $0.font = UIFont(name: "SFProText-Regular", size: Constants.textSize)
          $0.translatesAutoresizingMaskIntoConstraints = false
          return $0
     } (UILabel())
     
     private lazy var favouriteButton: UIButton = {
          $0.addTarget(self, action: #selector(favouriteAction), for: .touchUpInside)
          $0.translatesAutoresizingMaskIntoConstraints = false
          return $0
     } (UIButton())
     
     // MARK: - Properties
     
     var title: String = "" {
          didSet {
               titleLabel.text = title
          }
     }
     var image: String = "" {
          didSet {
               imageView.loadImage(from: URL(string: image))
          }
     }
     var isFavourite: Bool = false {
          didSet {
               let image = isFavourite ? Constants.fillHeartImage : Constants.emptyHeartImage
               favouriteButton.setImage(image, for: .normal)
          }
     }
     
     override var isHighlighted: Bool {
          didSet {
               UIView.animate(withDuration: Constants.duration) {
                    self.transform = self.isHighlighted ? CGAffineTransform(scaleX: Constants.transformScale, y: Constants.transformScale) : .identity
               }
          }
     }
     
     // MARK: - Actions
     
     @objc
     private func favouriteAction() {
          isFavourite = !isFavourite
          didFavouriteTapped?(isFavourite)
     }
     
     // MARK: - Initiaize
     
     override public init(frame: CGRect) {
          super.init(frame: frame)
          backgroundColor = .white
          placeSubviews()
     }
     
     public required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          fatalError("init has not been implemented")
     }
}

// MARK: - Place Views Methods

private extension MainItemCollectionViewCell {
     
     func placeSubviews() {
          placeImageView()
          placeTitle()
          placeButton()
     }
     
     func placeImageView() {
          addSubview(imageView)
          imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
          imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
          imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
          imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.imageBottomInset).isActive = true
     }
     
     func placeTitle() {
          addSubview(titleLabel)
          titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
          titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
          titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.titleTopInset).isActive = true
          titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
     }
     
     func placeButton() {
          addSubview(favouriteButton)
          favouriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.buttonInsets).isActive = true
          favouriteButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.buttonInsets).isActive = true
          favouriteButton.widthAnchor.constraint(equalToConstant: Constants.buttonWigth).isActive = true
          favouriteButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight).isActive = true
     }
}
