//
//  PicturesService.swift
//  SurfEducationProject
//
//  Created by Alina Kharunova on 15.08.2022.
//

import Foundation

struct PicturesService {

    let dataTask = BaseNetworkTask<EmptyModel, [PictureResponseModel]>(
        inNeedInjectToken: true,
        method: .get,
        path: "picture/"
    )

    func loadPictures(_ onResponseWasReceived: @escaping (_ result: Result<[PictureResponseModel], Error>) -> Void) {
        dataTask.performRequest(onResponseWasReceived)
    }
}
