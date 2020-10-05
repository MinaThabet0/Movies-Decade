//
//  FlickrModel.swift
//  MovieTask
//
//  Created by Mina Thabet on 05/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation

struct FlickrModel: Codable {
    let photos: FlickerPage
}

struct FlickerPage: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [FlickrPhoto]
}


struct FlickrPhoto: Codable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
}




