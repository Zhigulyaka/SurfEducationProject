//
//  BaseViewController.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 13.08.2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    // MARK: - Properties
    
    private let searchController: UISearchController = {
        $0.searchBar.barStyle = .default
        $0.searchBar.searchBarStyle = .minimal
        $0.obscuresBackgroundDuringPresentation = false
        $0.definesPresentationContext = false
        return $0
    }(UISearchController(searchResultsController: nil))
    
    var searchText = ""
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureBaseNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: true)
        searchController.resignFirstResponder()
    }
    
    // MARK: - NavBar
    
    func configureBaseNavigationBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
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
        
        if let controllersCount = navigationController?.viewControllers.count,
           controllersCount > 1 {
            addBackItem()
        }
    }
    
    func addBackItem() {
        let back = UIBarButtonItem(image: UIImage(named: "navBarBack"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = back
    }
    
    func addSearchItem() {
        let search = UIBarButtonItem(image: UIImage(named: "navBarSearch"), style: .plain, target: self, action: #selector(searchAction))
        navigationItem.rightBarButtonItem = search
    }
    
    // MARK: - UISearchController
    
    public func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        searchController.view.layoutIfNeeded()
        
        if #available(iOS 13.0, *) {

            searchController.searchBar.searchTextField.smartDashesType = .no
            searchController.searchBar.searchTextField.autocorrectionType = .no
            searchController.searchBar.searchTextField.autocapitalizationType = .none
            searchController.searchBar.searchTextField.spellCheckingType = .no
            
            searchController.searchBar.setImage(UIImage(named: "clearButton"), for: .clear, state: .normal)
            searchController.searchBar.searchTextField.layer.cornerRadius = 19
            searchController.searchBar.searchTextField.layer.cornerCurve = .continuous
            searchController.searchBar.searchTextField.clipsToBounds = true
        }
        
        searchController.searchBar.searchTextField.placeholder = "Поиск"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
    }
    
    // MARK: - Actions
    
    @objc func searchAction(_: Any) {}
    
    @objc func backAction(_: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UISearchResultsUpdating

extension BaseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchText = searchController.searchBar.text ?? ""
    }
}

