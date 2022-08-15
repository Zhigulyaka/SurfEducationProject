//
//  NetworkMethod.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import Foundation

enum NetworkMethod: String {
    case get
    case post
}

extension NetworkMethod {

    var method: String {
        rawValue.uppercased()
    }
}
