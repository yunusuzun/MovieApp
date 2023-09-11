//
//  UITableView+Extension.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import UIKit

extension UITableView {
    func register<Cell: UITableViewCell>(cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(for cellClass: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as? Cell else {
            fatalError("Error dequeuing cell for identifier \(String(describing: cellClass))")
        }
        
        return cell
    }
}
