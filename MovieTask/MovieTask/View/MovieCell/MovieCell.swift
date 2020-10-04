//
//  MovieCell.swift
//  MovieTask
//
//  Created by Mina Thabet on 02/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import UIKit
import Cosmos

class MovieCell: UITableViewCell {
    
    //MARK:- IBOutlet
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var rateView: CosmosView!
    
    //MARK:- Variables
    var viewModel: MoviewCellViewModel? {
        didSet {
            bindViewMode()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func bindViewMode() {
        movieNameLabel.text = viewModel?.title
        yearLabel.text = viewModel?.yearFormat
        rateView.rating = Double(viewModel?.rating ?? 0)
    }
    
}
