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
    
    var items: [PictureResponseModel] = [] {
        didSet {
            didItemsUpdated?()
        }
    }
}
