//
//  UITableView+Extension.swift
//  MovieTask
//
//  Created by Mina Thabet on 03/10/2020.
//  Copyright © 2020 Egabi. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNib<Cell: UITableViewCell>(cell: Cell.Type) {
        let nibName = String(describing: Cell.self)
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell{
        let identifier = String(describing: Cell.self)
        
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? Cell else {
            fatalError("Error in dequeue cell")
        }
        
        return cell
    }
}
