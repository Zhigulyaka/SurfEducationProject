//
//  TabBarModel.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 07.08.2022.
//

import Foundation
import UIKit

enum TabBarModel {
    case main
    case favourites
    case profile
    
    private var image: UIImage? {
        switch self {
        case .main:
            return UIImage(named: "main")
        case .favourites:
            return UIImage(named: "favourites")
        case .profile:
            return UIImage(named: "profile")
        }
    }
    
    private var title: String {
        switch self {
        case .main:
            return "Главная"
        case .favourites:
            return "Избранное"
        case .profile:
            return "Профиль"
        }
    }
    
    public var tabBarItem: UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: image)
    }
    
    public var controller: UIViewController {
        switch self {
        case .main:
            return MainViewController()
        case .favourites:
            return FavouritesViewController()
        case .profile:
            return ProfileViewController()
        }
    }
}
