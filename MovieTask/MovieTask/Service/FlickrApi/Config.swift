//
//  Config.swift
//  MovieTask
//
//  Created by Mina Thabet on 05/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation

enum FlickerConfig {
    static let baseUrl = "https://api.flickr.com/services/rest"
    static let apiKey = "5bfc82f0ee38e2e4c1eaad78a7ec8873"
    static let method = "flickr.photos.search"
    static let format = "json"
}

enum Params {
    static let apiKey = "api_key"
    static let format = "format"
    static let nojsoncallback = "nojsoncallback"
    static let text = "text"
    static let page = "page"
    static let perPage = "per_page"
    static let method = "method"
}
