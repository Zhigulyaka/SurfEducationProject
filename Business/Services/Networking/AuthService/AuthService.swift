//
//  AuthService.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import Foundation

struct AuthService {

    let dataTask = BaseNetworkTask<AuthRequestModel, AuthResponseModel>(
        inNeedInjectToken: false,
        method: .post,
        path: "auth/login"
    )

    func performLoginRequestAndSaveToken(
        credentials: AuthRequestModel,
        _ onResponseWasReceived: @escaping (_ result: Result<AuthResponseModel, Error>) -> Void
    ) {
        dataTask.performRequest(input: credentials) { result in
            if case let .success(responseModel) = result {
                do {
                    try dataTask.tokenStorage.set(newToken: TokenContainer(token: responseModel.token, receivingDate: Date()))
                } catch {
                   // TODO: - Handle error if token not was received from server
                }
            }

            DispatchQueue.main.async {
                onResponseWasReceived(result)
            }
        }
    }
}
