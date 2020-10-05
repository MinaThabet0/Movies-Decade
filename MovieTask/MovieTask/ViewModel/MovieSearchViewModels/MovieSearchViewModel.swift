//
//  MovieSearchViewModel.swift
//  MovieTask
//
//  Created by Mina Thabet on 03/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//
import Foundation

class MovieSearchViewModel {
    
    enum MovieTableCellType {
        case normal(cellViewModel: MoviewCellViewModel)
        case error(message: String)
        case empty
    }
    
    enum MovieSearchTableCellType{
        case search(cellViewModel: MoviesPerYearViewModel)
        case empty
    }
    
    let showLoading: Bindable = Bindable(false)
    let moviesCells = Bindable([MovieTableCellType]())
    let moviesSearchCells = Bindable([MovieSearchTableCellType]())
    
    
    let apiClient: APIService
    var moviesList: [Movies]
    var moviePerYearList: [MoviesPerYear]
    var dataSourceMode: DataSourceMode
    
    init(apiClient: APIService = APIService(),moviesList: [Movies] = [], moviePerYearList: [MoviesPerYear] = [], dataSourceMode: DataSourceMode = .anyOrder) {
        self.apiClient = apiClient
        self.moviesList = moviesList
        self.moviePerYearList = moviePerYearList
        self.dataSourceMode = dataSourceMode
    }
    
    func getMoviesList() {
        showLoading.value = true
        apiClient.fetchAllMovies { [weak self] result in
            self?.showLoading.value = false
            switch result {
            case .success(let movies):
                guard movies.count > 0 else {
                    self?.moviesCells.value = [.empty]
                    return
                }
                self?.setDataSourceMode(mode: .anyOrder)
                self?.prepareSuccessList(movies: movies)
            case .failure(let error):
                print("🙆‍♂️\(error)🙆‍♂️")
                switch error {
                case APIError.invalidFileName:
                    self?.moviesCells.value = [.error(message: "Invalid file name")]
                default:
                    self?.moviesCells.value = [.error(message: "Loading failed, check network connection")]
                }
            }
        }
    }
    
    private func prepareSuccessList(movies: [Movies]) {
        self.moviesList = movies.sorted { $0.year ?? 1900 > $1.year ?? 1900 }
        self.moviePerYearList = self.sortMovieListPerYear(list: movies)
        self.moviesCells.value = moviesList.compactMap {
            .normal(cellViewModel: MoviewCellViewModel(movie: $0))
        }
    }
    
    private func setDataSourceMode(mode: DataSourceMode) {
        self.dataSourceMode = mode
    }
    
    private func sortMovieListPerYear(list: [Movies]) -> [MoviesPerYear] {
        let sorted = list.sorted { $0.rating ?? 0 > $1.rating ?? 0 }
        let categoryDictionary = Dictionary(grouping: sorted) { $0.year }
        return categoryDictionary.map {MoviesPerYear(year: $0.key ?? 1900 , movies: $0.value)}.sorted { $0.year ?? 1900 > $1.year ?? 1900}
    }
    
    
    
    //MARK:- Search
    func filterSearch(searchText: String) {
        if searchText.isEmpty {
            resetData()
        } else {
            setDataSourceMode(mode: .search)
            let filterList = query(list: moviePerYearList, keyword: searchText)
            if filterList.count == 0{
                self.moviesSearchCells.value = [.empty]
            }else {
                self.moviesSearchCells.value = filterList.compactMap {
                    .search(cellViewModel: MoviesPerYearViewModel(moviesPerYear: $0))
                }
            }
            
        }
    }
    
    private func moviesPerYear(moviesPerYear: MoviesPerYear, keyword: String) -> MoviesPerYear? {
        guard let movies = moviesPerYear.movies else {
            return nil
        }
        let atMostTopRatedFive = movies.filter {($0.title?.lowercased().contains(keyword.lowercased()) ?? false)}.prefix(5)
        return atMostTopRatedFive.isEmpty ? nil : MoviesPerYear(year: moviesPerYear.year ?? 1900, movies: Array(atMostTopRatedFive))
    }

    private func query(list: [MoviesPerYear], keyword: String) -> [MoviesPerYear] {
        let filterdResults = list.compactMap {
            moviesPerYear(moviesPerYear: $0, keyword: keyword)
        }
        return filterdResults
    }

    
    func resetData() {
        setDataSourceMode(mode: .anyOrder)
        if self.moviesList.count == 0 {
            self.moviesCells.value = [.empty]
        }else {
            self.moviesCells.value = self.moviesList.compactMap {
                .normal(cellViewModel: MoviewCellViewModel(movie: $0))
            }
        }

    }
    

    
}
