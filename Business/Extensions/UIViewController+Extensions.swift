//
//  UIViewController+Extensions.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 13.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    // MARK: - CollectionView
    
    func addCollectionView(layout: UICollectionViewFlowLayout) -> UICollectionView {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MainItemCollectionViewCell.self, forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        return collectionView
    }
    
    func addTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)

        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        return tableView
    }
}

