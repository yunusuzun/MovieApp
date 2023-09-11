//
//  UIImageView+Extension.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import class UIKit.UIImageView
import Foundation

extension UIImageView {
    func download(url: String) {
        ImageCacheManager.shared.downloadImage(from: url) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
