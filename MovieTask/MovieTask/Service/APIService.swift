//
//  APIService.swift
//  MovieTask
//
//  Created by Mina Thabet on 02/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidFileName
}

protocol APIServiceProtocol {
    func fetchAllMovies(completionHandler: @escaping (Result<[Movies], Error>)->() )
}

class APIService: APIServiceProtocol {
    func fetchAllMovies(completionHandler: @escaping (Result<[Movies], Error>)->() ) {
        guard let path = Bundle.main.path(forResource: "movies", ofType: "json") else {
            completionHandler(.failure(APIError.invalidFileName))
            return
        }
        do {
          let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
          let decoder = JSONDecoder()
          decoder.dateDecodingStrategy = .iso8601
            do {
                let movies = try decoder.decode(MoviesModel.self, from: data)
                completionHandler(.success(movies.movies ?? []))
            }catch{
                // handle error
                completionHandler(.failure(error))
            }

        } catch let error{
           // handle error
            completionHandler(.failure(error))
        }
    }
}
