//
//  FlickrNetworkManager.swift
//  MovieTask
//
//  Created by Mina Thabet on 05/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation
import Moya

protocol FlickrNetworkProtocol {
    func fetchPhotoList(movieTitle: String,completionHandler: @escaping (Result<[FlickrPhoto], Error>)->() )
}

class FlickrNetworkManager {
    let provider = MoyaProvider<FlickrApi>(plugins: [NetworkLoggerPlugin()])
}

extension FlickrNetworkManager: FlickrNetworkProtocol {
    
    func fetchPhotoList(movieTitle: String,completionHandler: @escaping (Result<[FlickrPhoto], Error>) -> ()) {
        provider.request(.photoList(movieTitle: movieTitle)) { result in
            switch result {
            case .success(let response):
                do {
                    let photo = try JSONDecoder().decode(FlickrModel.self, from: response.data)
                    completionHandler(.success(photo.photos.photo))
                } catch let error {
                    // handle error
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                // handle error
                completionHandler(.failure(error))
            }
        }
    }
}
