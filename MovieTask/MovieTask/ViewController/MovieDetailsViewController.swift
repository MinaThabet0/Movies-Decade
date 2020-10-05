//
//  MovieDetailsViewController.swift
//  MovieTask
//
//  Created by Mina Thabet on 05/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import UIKit
import Cosmos
import MBProgressHUD

class MovieDetailsViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    //MARK:- Constant
    let viewModel: MovieDetailViewModel = MovieDetailViewModel()
    
    //MARK:- Variables
    var movieViewModel: MoviewCellViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
}

//MARK:- Helpers
extension MovieDetailsViewController {
    func initView() {
        initMovieData()
        initCommonCollectionView()
        bindViewModel()
    }
    
    func initMovieData() {
        if let movie = movieViewModel {
            viewModel.fetchPhotoList(movieTitle: movie.title)
            nameLabel.text = movie.title
            yearLabel.text = movie.yearFormat
            ratingView.rating = Double(movie.rating)
            castLabel.text = movie.castByCommo
            genresLabel.text = movie.genresByCommo
        }
    }
    
    func bindViewModel() {
        viewModel.photoCells.bindAndFire { [weak self] _ in
            self?.collectionView.reloadData()
            let contentHeight = self?.collectionView.collectionViewLayout.collectionViewContentSize.height
            self?.collectionHeightConstraint.constant = ((contentHeight ?? 128) == 0 ? 128 : contentHeight) ?? 128
            self?.collectionView.reloadData()
        }
        
        viewModel.showLoading.bind { [weak self] show in
            if self != nil  {
                if show {
                    MBProgressHUD.showAdded(to: self!.view, animated: true)
                }else {
                    MBProgressHUD.hide(for: self!.view, animated: true)
                }
            }
        }
    }
    
    func initCommonCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerNib(cell: FlickrPhotoCell.self)
        self.collectionView.registerNib(cell: EmtyCollectionCell.self)
    }
    
}

//MARK:- UI Collection View Delegate, DataSource
extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photoCells.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.photoCells.value[indexPath.item] {
        case .normal(let viewModel):
            let cell = collectionView.dequeue(index: indexPath) as FlickrPhotoCell
            cell.viewModel = viewModel
            return cell
        case .empty:
            let cell = collectionView.dequeue(index: indexPath) as EmtyCollectionCell
            cell.messageLabel.text = "No Image Avaliable"
            return cell
        case .error(let error):
            let cell = collectionView.dequeue(index: indexPath) as EmtyCollectionCell
            cell.messageLabel.text = error
            return cell
        }
    }
    
    
}


//MARK:- UI Collection View Delegate Flow Layout
extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.photoCells.value[indexPath.item] {
        case .normal:
            let width = (collectionView.bounds.width - 10) / 2
            return CGSize(width: width, height: width)
        default:
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }

    }
}
