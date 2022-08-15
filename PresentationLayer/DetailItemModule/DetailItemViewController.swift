//
//  DetailItemViewController.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import UIKit

final class DetailItemViewController: BaseViewController {
    // MARK: - Properties
    
    var itemModel: PictureResponseModel?
    
    // MARK: - Sublayers
    
    private var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addSearchItem()
        navigationItem.title = itemModel?.title ?? ""
    }
}

// MARK: - Private method

private extension DetailItemViewController {
    
    func configureTableView() {
        tableView = addTableView()

        tableView.register(ItemImageTableViewCell.self, forCellReuseIdentifier: "\(ItemImageTableViewCell.self)")
        tableView.register(TitleDateTableViewCell.self, forCellReuseIdentifier: "\(TitleDateTableViewCell.self)")
        tableView.register(DescriptionTextTableViewCell.self, forCellReuseIdentifier: "\(DescriptionTextTableViewCell.self)")
    }
}

// MARK: - UITableView

extension DetailItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = itemModel else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ItemImageTableViewCell.self)", for: indexPath)
            guard let cell = cell as? ItemImageTableViewCell else {
                return cell
            }
            cell.imageUrl = model.photoUrl
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleDateTableViewCell.self)", for: indexPath)
            guard let cell = cell as? TitleDateTableViewCell else {
                return cell
            }
            cell.titleText = model.title
            cell.dateText = model.dateString
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DescriptionTextTableViewCell.self)", for: indexPath)
            guard let cell = cell as? DescriptionTextTableViewCell else {
                return cell
            }
            cell.descText = model.content
            return cell
        default: return UITableViewCell()
        }
    }
}
