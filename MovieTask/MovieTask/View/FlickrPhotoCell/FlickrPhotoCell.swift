//
//  FlickrPhotoCell.swift
//  MovieTask
//
//  Created by Mina Thabet on 05/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import UIKit
import Nuke

class FlickrPhotoCell: UICollectionViewCell {

    //MARK:- IBOutlet
    @IBOutlet weak var flickrImageView: UIImageView!
    
    //MARK:- Variables
    var viewModel: FlickrCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func bindViewModel() {
        let options = ImageLoadingOptions(placeholder: UIImage(named: "movie-logo-vector"), transition: .fadeIn(duration: 0.3), failureImage: UIImage(named: "movie-logo-vector"), contentModes: .init(success: .scaleAspectFill, failure: .scaleAspectFit, placeholder: .scaleAspectFit))
        if let url = viewModel?.imageUrl {
            Nuke.loadImage(with: url, options: options, into: flickrImageView)
        }
        
    }
}
