//
//  MoviesPerYearViewModel.swift
//  MovieTask
//
//  Created by Mina Thabet on 04/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation

struct MoviesPerYearViewModel {
    
    private var moviesPerYear: MoviesPerYear
    
    init(moviesPerYear: MoviesPerYear) {
        self.moviesPerYear = moviesPerYear
    }
    
    var year: Int {
        guard let year = moviesPerYear.year else {
            return 1970
        }
        return year
    }
    
    var movies: [MoviewCellViewModel] {
        guard let movies = moviesPerYear.movies else {
            return []
        }
        let list = movies.map {
            MoviewCellViewModel(movie: $0)
        }
        return list
    }
}
