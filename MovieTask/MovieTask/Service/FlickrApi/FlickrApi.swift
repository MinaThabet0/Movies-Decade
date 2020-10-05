//
//  FlickrApi.swift
//  MovieTask
//
//  Created by Mina Thabet on 05/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation
import Moya

enum FlickrApi {
    case photoList(movieTitle: String)
}

extension FlickrApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: FlickerConfig.baseUrl) else {
            preconditionFailure("Invalid url")
        }
        return url
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .photoList(let movieTitle):
            var parameters = [String: Any]()
            parameters = [Params.apiKey: FlickerConfig.apiKey, Params.format: FlickerConfig.format, Params.nojsoncallback: 1]
            parameters[Params.text] = movieTitle
            parameters[Params.page] = 1
            parameters[Params.perPage] = 10
            parameters[Params.method] = FlickerConfig.method
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        nil
    }
}

