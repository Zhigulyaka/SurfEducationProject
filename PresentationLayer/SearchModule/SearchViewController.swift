//
//  SearchViewController.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 16.08.2022.
//

import UIKit

final class SearchViewController: BaseViewController {
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
    private var plugView: PlugSearchView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    } (PlugSearchView())
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        definesPresentationContext = true
        
        configureCollectionView()
        configureModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSearchController()
        setupPlugView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - Private method

private extension SearchViewController {
    
    func configureCollectionView() {
        collectionView = addCollectionView(layout: configureCollectionLayout())
        collectionView.register(MainItemCollectionViewCell.self, forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
        collectionView.keyboardDismissMode = .onDrag
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
        layout.estimatedItemSize = .zero
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
    
    func setupPlugView() {
        view.addSubview(plugView)
        
        plugView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        plugView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        plugView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 169.0 * (view.frame.height/812.0)).isActive = true
        
        plugView.mode = .input
    }
}

// MARK: - UICollectionView

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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

extension SearchViewController {
    override func updateSearchResults(for searchController: UISearchController) {
        super.updateSearchResults(for: searchController)

        if searchText != "" {
            model.filteredItems = model.items.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            plugView.setHidden(!model.filteredItems.isEmpty)
            plugView.mode = model.filteredItems.isEmpty ? .notFound : .input
        } else {
            model.filteredItems = []
            plugView.setHidden(false)
            plugView.mode = .input
        }
    }
}
