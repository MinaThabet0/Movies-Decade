//
//  MockService.swift
//  MovieTaskTests
//
//  Created by Mina Thabet on 06/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation
@testable import MovieTask

class MockService: APIServiceProtocol {
    let mockData: [Movies]?
    
    init(mockData: [Movies]?) {
        self.mockData = mockData
    }
    
    func fetchAllMovies(completionHandler: @escaping (Result<[Movies], Error>) -> ()) {
        if let data = mockData {
            completionHandler(.success(data))
        }else {
            completionHandler(.success([]))
        }
        
    }
}
