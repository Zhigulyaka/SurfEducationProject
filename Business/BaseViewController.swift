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
        $0.definesPresentationContext = true
        return $0
    }(UISearchController(searchResultsController: nil))
    
    var searchText = ""
    var isSearchMode = false
    
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
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = false
        //     searchController.becomeFirstResponder()
        
        if #available(iOS 13.0, *) {
            
            searchController.searchBar.searchTextField.leftView?.tintColor = .placeholderText
            searchController.searchBar.searchTextField.backgroundColor = .systemBackground
            
            searchController.searchBar.searchTextField.smartDashesType = .no
            searchController.searchBar.searchTextField.autocorrectionType = .no
            searchController.searchBar.searchTextField.autocapitalizationType = .none
            searchController.searchBar.searchTextField.spellCheckingType = .no
            
            searchController.searchBar.searchTextField.placeholder = "Поиск"
        }
        navigationController?.navigationBar.topItem?.searchController = searchController
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

// MARK: - UISearchControllerDelegate

extension BaseViewController: UISearchControllerDelegate {
    func willPresentSearchController(_: UISearchController) {
        isSearchMode = true
        searchController.becomeFirstResponder()
    }
    
    func willDismissSearchController(_: UISearchController) {
        searchText = ""
        isSearchMode = false
        searchController.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate

extension BaseViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_: UISearchBar) {
        searchText = ""
        searchController.resignFirstResponder()
    }
}

