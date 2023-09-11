//
//  ImageDownloader.swift
//  MovieApp
//
//  Created by Yunus Uzun on 7.09.2023.
//

import Foundation
import class UIKit.UIImage

final class ImageCacheManager {
    private var imageCache = NSCache<NSString, UIImage>()
    
    static let shared = ImageCacheManager()
    
    private init() { }
    
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = urlString as NSString
        
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self,
                  error == nil,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.imageCache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        
        task.resume()
    }
}
