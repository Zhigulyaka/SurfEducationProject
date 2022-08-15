//
//  TokenStorage.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import Foundation

protocol TokenStorage {

    func getToken() throws -> TokenContainer
    func set(newToken: TokenContainer) throws

}
