//
//  MainViewController.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 07.08.2022.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Constants
    
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 10
        static let spacingBetweenColumns: CGFloat = 7
        static let spacingBetweenRows: CGFloat = 16
    }
    
    // MARK: - Properties
    
    //Private
    private let model = MainModel()
    
    // MARK: - Sublayers
    
    private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureModel()
        configureAppearance()
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func configureAppearance() {
        configureCollectionView()
        placeCollectionView()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: configureCollectionLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(MainItemCollectionViewCell.self, forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.dataSource = self
    }
    
    func configureCollectionLayout() -> UICollectionViewFlowLayout {
        let width = (view.bounds.width - Constants.spacingBetweenColumns) / 2 - Constants.horizontalInset
        let height = width * 1.46
        let cellSize = CGSize(width: width, height: height)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.sectionInset = .init(top: Constants.verticalInset,
                                   left: Constants.horizontalInset,
                                   bottom: Constants.verticalInset,
                                   right: Constants.horizontalInset)
        layout.minimumLineSpacing = Constants.spacingBetweenRows
        layout.minimumInteritemSpacing = .zero
        return layout
    }
    
    func placeCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func configureModel() {
        model.getPosts()
        model.didItemsUpdated = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionView

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainItemCollectionViewCell", for: indexPath)
        guard let cell = cell as? MainItemCollectionViewCell else {
            return cell
        }
        let item = model.items[indexPath.row]
        cell.title = item.title
        cell.image = item.image
        cell.isFavourite = item.isFavourite
        cell.didFavouriteTapped = { [weak self] isFavourite in
            guard let self = self else { return }
            self.model.items[indexPath.item].isFavourite = isFavourite
        }
        return cell
    }
}
