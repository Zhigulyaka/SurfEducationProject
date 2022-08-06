//
//  AppDelegate.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 06.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        viewController.view.backgroundColor = .red
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}

