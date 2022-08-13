//
//  BaseViewController.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 13.08.2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureBaseNavigationBar()
    }
    
    // MARK: - NavBar
    
    func configureBaseNavigationBar() {
        if #available(iOS 13.0, *) {
            let style = UINavigationBarAppearance()

            style.configureWithOpaqueBackground()
            style.shadowColor = .white
            style.backgroundColor = .white

            navigationController?.navigationBar.standardAppearance = style
            navigationController?.navigationBar.scrollEdgeAppearance = style
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        } else {
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        }
    }
    
    func addSearchItem() {
        let search = UIBarButtonItem(image: UIImage(named: "navBarSearch"), style: .plain, target: self, action: #selector(searchAction))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = search
    }

    // MARK: - Actions
    
    @objc func searchAction(_: Any) {}
}
