//
//  UICollectionView+Extension.swift
//  MovieApp
//
//  Created by Yunus Uzun on 8.09.2023.
//

import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(cellClass: Cell.Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(for cellClass: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? Cell else {
            fatalError("Error dequeuing cell for identifier \(String(describing: cellClass))")
        }
        
        return cell
    }
}
