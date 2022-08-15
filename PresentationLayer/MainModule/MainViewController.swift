//
//  MainViewController.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 07.08.2022.
//

import UIKit

class MainViewController: BaseViewController {
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
        configureCollectionView()
        
        let crendentials = AuthRequestModel(phone: "+79876543219", password: "qwerty")
//        AuthService().performLoginRequestAndSaveToken(credentials: crendentials) { result in
//            switch result {
//            case let .failure(error):
//                print(error)
//            case let .success(resp):
//                print(resp)
//            }
//        }
        PicturesService().loadPictures { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                break
            case let .success(resp):
                self.model.items = resp
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSearchItem()
        navigationController?.navigationBar.topItem?.title = "Главная"
        configureSearchController()
    }
    
    // MARK: - Actions
    
    override func searchAction(_: Any) {
        print("tapped")
    }
}

// MARK: - Private Methods

private extension MainViewController {
    
    func configureCollectionView() {
        collectionView = addCollectionView(layout: configureCollectionLayout())
        collectionView.register(MainItemCollectionViewCell.self, forCellWithReuseIdentifier: "\(MainItemCollectionViewCell.self)")
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
    
    func configureModel() {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainItemCollectionViewCell.self)", for: indexPath)
        guard let cell = cell as? MainItemCollectionViewCell else {
            return cell
        }
        let item = model.items[indexPath.row]
        cell.title = item.title
        cell.image = item.photoUrl
        cell.isFavourite = false
        cell.didFavouriteTapped = { [weak self] isFavourite in
            guard let self = self else { return }
      //      self.model.items[indexPath.item].isFavourite = isFavourite
        }
        return cell
    }
}
