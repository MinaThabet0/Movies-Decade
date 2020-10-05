//
//  MovieDetailViewModel.swift
//  MovieTask
//
//  Created by Mina Thabet on 05/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    enum MovieDetailCellType {
        case normal(cellViewModel: FlickrCellViewModel)
        case error(message: String)
        case empty
    }
    
    let showLoading: Bindable = Bindable(false)
    let photoCells = Bindable([MovieDetailCellType]())
    
    let apiClient: FlickrNetworkManager
    
    init(apiClient: FlickrNetworkManager = FlickrNetworkManager()) {
        self.apiClient = apiClient
    }
    
    func fetchPhotoList(movieTitle: String) {
        showLoading.value = true
        apiClient.fetchPhotoList(movieTitle: movieTitle) { [weak self] result in
            self?.showLoading.value = false
            switch result{
            case .success(let photoList):
                print(photoList)
                if photoList.count == 0 {
                    self?.photoCells.value = [.empty]
                    return
                }
                self?.photoCells.value = photoList.compactMap{
                    .normal(cellViewModel: FlickrCellViewModel(photo: $0))
                }
            case .failure(let error):
                print("🙆‍♂️\(error)🙆‍♂️")
                self?.photoCells.value = [.error(message: "Loading failed, check network connection")]
            }
        }
    }
    
}
