//
//  AppDelegate.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 06.08.2022.
//

import UIKit
import Atlantis

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
#if DEBUG
    Atlantis.start(hostName: "alinas-macbook-air.local.")
#endif
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        goToMain()
        return true
    }
    
    func goToMain() {
   //     window?.rootViewController = UINavigationController(rootViewController: AuthorizationViewController())
        window?.rootViewController = TabBarConfigurator().configure()
    }
}

