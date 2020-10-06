//
//  MovieSearchViewModelTests.swift
//  MovieTaskTests
//
//  Created by Mina Thabet on 06/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import XCTest
@testable import MovieTask

class MovieSearchViewModelTests: XCTestCase {
    
    func testSuccessFetchData() {
        let expectedList = [Movies.withMock(),Movies.withMock(title: "Second Moview", year: 2017, cast: ["Mina"], genres: ["Action"], rating: 4)]
        
        let service = MockService(mockData: expectedList)
        
        let viewModel = MovieSearchViewModel(apiClient: service, moviesList: [], moviePerYearList: [], dataSourceMode: .anyOrder)
        
        viewModel.getMoviesList()
        
        XCTAssertTrue(!viewModel.showLoading.value)
        XCTAssertEqual(viewModel.moviesCells.value.count, 2)
        XCTAssertEqual(viewModel.moviesList.count, 2)
        XCTAssertEqual(viewModel.moviePerYearList.count, 2)
    }
    
    func testEmptyData() {
        let expectedList = [Movies]()
        
        let service = MockService(mockData: expectedList)
        
        let viewModel = MovieSearchViewModel(apiClient: service, moviesList: [], moviePerYearList: [], dataSourceMode: .anyOrder)
        
        viewModel.getMoviesList()
        
        XCTAssertTrue(!viewModel.showLoading.value)
        XCTAssertEqual(viewModel.moviesCells.value.count, 1)
        XCTAssertEqual(viewModel.moviesList.count, 0)
        XCTAssertEqual(viewModel.moviePerYearList.count, 0)
    }
    
    func testNilData() {
        let expectedList: [Movies]? = nil
        
        let service = MockService(mockData: expectedList)
        
        let viewModel = MovieSearchViewModel(apiClient: service, moviesList: [], moviePerYearList: [], dataSourceMode: .anyOrder)
        
        viewModel.getMoviesList()
        
        XCTAssertTrue(!viewModel.showLoading.value)
        XCTAssertEqual(viewModel.moviesCells.value.count, 1)
        XCTAssertEqual(viewModel.moviesList.count, 0)
        XCTAssertEqual(viewModel.moviePerYearList.count, 0)
    }
    
    func testSearch() {
        let expectedList = [Movies.withMock(),Movies.withMock(title: "Second Moview", year: 2017, cast: ["Mina"], genres: ["Action"], rating: 4)]
        
        let service = MockService(mockData: expectedList)
        
        let viewModel = MovieSearchViewModel(apiClient: service, moviesList: [], moviePerYearList: [], dataSourceMode: .search)
        
        viewModel.getMoviesList()
        
        viewModel.filterSearch(searchText: "s")
        
        XCTAssertEqual(viewModel.moviesSearchCells.value.count, 2)
    }
    
}
