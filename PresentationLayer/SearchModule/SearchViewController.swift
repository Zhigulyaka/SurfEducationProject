//
//  SearchViewController.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 16.08.2022.
//

import UIKit

final class SarchViewController: BaseViewController {
    // MARK: - Constants
    
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        static let verticalInset: CGFloat = 10
        static let spacingBetweenColumns: CGFloat = 7
        static let spacingBetweenRows: CGFloat = 16
        static let multiplier: CGFloat = 1.46
    }
    
    // MARK: - Properties
    
    var model = MainModel()
    
    // MARK: - Sublayers
    
    private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCollectionView()
        configureModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSearchController()
    }
}

// MARK: - Private method

private extension SarchViewController {
    
    func configureCollectionView() {
        collectionView = addCollectionView(layout: configureCollectionLayout())
        collectionView.register(MainItemCollectionViewCell.self, forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
    }
    
    func configureCollectionLayout() -> UICollectionViewFlowLayout {
        let width = (view.bounds.width - Constants.spacingBetweenColumns) / 2 - Constants.horizontalInset
        let height = width * Constants.multiplier
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
    
    func configureModel() {
        model.didItemsUpdated = { [weak self] in
            guard let self = self else { return }
            self.collectionView.performBatchUpdates({
                let indexSet = IndexSet(integersIn: 0 ... 0)
                self.collectionView.reloadSections(indexSet)
            }, completion: nil)
        }
    }
}

// MARK: - UICollectionView

extension SarchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_: UICollectionView, numberOfItemsInSection: Int) -> Int {
        return model.filteredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        guard let cell = cell as? MainItemCollectionViewCell else {
            return cell
        }
        let item = model.filteredItems[indexPath.row]
        cell.title = item.title
        cell.image = item.photoUrl
        cell.isFavourite = false
        cell.didFavouriteTapped = { [weak self] isFavourite in
            guard let self = self else { return }
      //      self.model.items[indexPath.item].isFavourite = isFavourite
        }
        return cell
    }
    
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailItemViewController()
        controller.itemModel = model.filteredItems[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - SearchDelegate

extension SarchViewController {
    override func updateSearchResults(for searchController: UISearchController) {
        super.updateSearchResults(for: searchController)

        if searchText != "" {
            model.filteredItems = model.items.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        } else {
            model.filteredItems = []
        }
    }
}
