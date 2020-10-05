//
//  MovieCellViewModel.swift
//  MovieTask
//
//  Created by Mina Thabet on 03/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

struct MoviewCellViewModel {
    private let movie: Movies
    init(movie: Movies) {
        self.movie = movie
    }
    var title: String {
        guard let title = movie.title else {
            return ""
        }
        return title
    }
    var year: Int {
        guard let year = movie.year else {
            return 1900
        }
        return year
    }
    var yearFormat: String {
        guard let year = movie.year else {
            return "(1900)"
        }
        return "(\(year))"
    }
    var castList: [String] {
        guard let list = movie.cast else {
            return []
        }
        return list
    }
    
    var castByCommo: String {
        guard let list = movie.cast else {
            return ""
        }
        return list.joined(separator: ", ")
    }
    
    var genresList: [String] {
        guard let list = movie.genres else {
            return []
        }
        return list
    }
    
    var genresByCommo: String {
        guard let list = movie.genres else {
            return ""
        }
        return list.joined(separator: ", ")
    }
    
    var rating: Int {
        guard let rating = movie.rating else {
            return 0
        }
        return rating
    }
}
