//
//  UICollectionView+Extension.swift
//  MovieTask
//
//  Created by Mina Thabet on 03/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerNib<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func dequeue<Cell: UICollectionViewCell>(index: IndexPath) -> Cell{
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: index) as? Cell else {
            fatalError("Error in dequeue cell")
        }
        
        return cell
    }
}
