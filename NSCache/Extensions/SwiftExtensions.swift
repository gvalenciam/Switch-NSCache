//
//  SwiftExtensions.swift
//  NSCache
//
//  Created by Gerardo Valencia on 4/06/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, withCache cache: ImageCache, imageCacheId: URL, contentMode mode: ContentMode = .scaleAspectFit, withTintColor: Bool = false) {
        
        self.contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
               let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
               let data = data, error == nil,
               var image = UIImage(data: data) {
                
                // Save image on Cache
                cache[imageCacheId] = image
                print("IMAGE SAVED ON CACHE WITH ID: \(imageCacheId.absoluteString)")
                
                DispatchQueue.main.async() { [weak self] in
                    
                    if (withTintColor) {
                        image = image.withRenderingMode(.alwaysTemplate)
                    }
                                    
                    self?.image = image
                    
                }
                
            } else {
                return
            }
            
        }.resume()
        
    }
    
    func downloaded(from link: String,
                    withCache cache: ImageCache,
                    imageCacheId: URL,
                    contentMode mode: ContentMode = .scaleAspectFit,
                    withTintColor: Bool = false) {
        
        if let url = URL(string: link) {
            downloaded(from: url, withCache: cache, imageCacheId: imageCacheId, withTintColor: withTintColor)
        } else {
            return
        }
        
    }
    
}
