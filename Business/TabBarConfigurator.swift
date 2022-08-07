//
//  TabBarConfigurator.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 07.08.2022.
//

import Foundation
import UIKit

class TabBarConfigurator {
    
    // MARK: - Properties
    
    private var allTabs: [TabBarModel] = [.main, .favourites, .profile]
    
    // MARK: - Internal func
    
    func configure() -> UITabBarController {
        return getTabBarController()
    }
}

private extension TabBarConfigurator {
    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getViewControllers()
        return tabBarController
    }
    
    func getViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        allTabs.forEach { tab in
            let controller = tab.controller
            controller.tabBarItem = tab.tabBarItem
            viewControllers.append(controller)
        }
        
        return viewControllers
    }
}
