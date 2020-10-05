//
//  FlickrCellViewModel.swift
//  MovieTask
//
//  Created by Mina Thabet on 05/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation

struct FlickrCellViewModel {
    private var photo: FlickrPhoto
    init(photo: FlickrPhoto) {
        self.photo = photo
    }
    var id: String {
        guard let id = photo.id else {
            return "-1"
        }
        return id
    }
    var owner: String {
        guard let owner = photo.owner else {
            return ""
        }
        return owner
    }
    var secret: String {
        guard let secret = photo.secret else {
            return ""
        }
        return secret
    }
    var server: String {
        guard let server = photo.server else {
            return ""
        }
        return server
    }
    var farm: Int {
        guard let farm = photo.farm else {
            return -1
        }
        return farm
    }
    var title: String {
        guard let title = photo.title else {
            return ""
        }
        return title
    }
    var imageUrl: URL? {
         let urlString = "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
         return URL(string: urlString)
    }
}
