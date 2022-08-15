//
//  PictureResponseModel.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import Foundation

struct PictureResponseModel: Decodable {

    // MARK: - Internal Properties
    let id: String
    let title: String
    let content: String
    let photoUrl: String

    var date: Date {
        Date(timeIntervalSince1970: publicationDate / 1000)
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }

    // MARK: - Private Properties
    private let publicationDate: Double
}
