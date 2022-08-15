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
     }
     
     // MARK: - Subviews
     
     private lazy var imageView: UIImageView = {
          $0.layer.cornerRadius = 12
          $0.clipsToBounds = true
          $0.contentMode = .scaleAspectFill
          $0.translatesAutoresizingMaskIntoConstraints = false
          return $0
     } (UIImageView())
     
     private lazy var titleLabel: UILabel = {
          $0.font = UIFont(name: "SFProText-Regular", size: 12)
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
     
     
     // MARK: - Place Views Methods
     
     private func placeSubviews() {
          placeImageView()
          placeTitle()
          placeButton()
     }
     
     private func placeImageView() {
          addSubview(imageView)
          imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
          imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
          imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
          imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24).isActive = true
     }
     
     private func placeTitle() {
          addSubview(titleLabel)
          titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
          titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
          titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
          titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
     }
     
     private func placeButton() {
          addSubview(favouriteButton)
          favouriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
          favouriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
          favouriteButton.widthAnchor.constraint(equalToConstant: 21).isActive = true
          favouriteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
     }
}
