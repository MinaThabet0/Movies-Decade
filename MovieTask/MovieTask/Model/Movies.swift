//
//  Movies.swift
//  MovieTask
//
//  Created by Mina Thabet on 02/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation

struct MoviesModel : Codable {
    let movies : [Movies]?
}

struct Movies : Codable {
    let title : String?
    let year : Int?
    let cast : [String]?
    let genres : [String]?
    let rating : Int?
}

struct MoviesPerYear {
    let year: Int?
    let movies: [Movies]?
    
    init(year: Int, movies: [Movies]) {
        self.year = year
        self.movies = movies
    }
}
