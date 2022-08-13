//
//  MainModel.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 11.08.2022.
//

import Foundation
import UIKit

final class MainModel {
    
    // MARK: - Handlers
    
    public var didItemsUpdated: (() -> Void)?
    
    // MARK: - Properties
    
    var items: [ItemModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
    
    // MARK: - Methods
    
    public func getPosts() {
        items = Array(repeating: ItemModel.createDefault(), count: 100)
    }
}

struct ItemModel {
    let image: UIImage?
    let title: String
    var isFavourite: Bool
    let dateCreation: String
    let content: String
    
    static func createDefault() -> ItemModel {
        .init(image: UIImage(named: "corgi"), title: "Самый милый корги", isFavourite: false, dateCreation: "11.08.2022", content: "Самый милый корги Самый милый корги Самый милый корги  Самый милый корги Самый милый корги Самый милый корги Самый милый корги  Самый милый коргиСамый милый коргиСамый милый корги Самый милый корги Самый милый корги Самый милый корги Самый милый коргиСамый милый корги Самый милый корги Самый милый корги Самый милый корги Самый милый корги Самый милый корги Самый милый корги Самый милый корги")
    }
}
