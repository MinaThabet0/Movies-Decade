//
//  MockMovie.swift
//  MovieTaskTests
//
//  Created by Mina Thabet on 06/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation
@testable import MovieTask

extension Movies {
    static func withMock(title: String = "Instant Family",year: Int = 2018,cast: [String] = ["Mina Thabet","Osama"],genres: [String] = ["Action"],rating: Int = 3) -> Movies {
        return Movies(title: title, year: year, cast: cast, genres: genres, rating: rating)
    }
}
