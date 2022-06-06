//
//  SwiftExtensions.swift
//  NSCache
//
//  Created by Gerardo Valencia on 4/06/22.
//

import Foundation
import UIKit

extension UIImageView {
    
    
    /// Function that downloads an image with the given URL.
    /// After image is downloaded it is saved into cache with the given iamgeCacheId and then assign in to the image view
    /// - Parameters:
    ///   - url: Image URL
    ///   - cache: Images cache reference
    ///   - imageCacheId: Key reference that will be used for the downloaded iamge
    ///   - mode: image content mode
    ///   - withTintColor: image tint color
    func downloaded(from url: URL,
                    withCache cache: ImageCache,
                    imageCacheId: URL,
                    contentMode mode: ContentMode = .scaleAspectFit,
                    withTintColor: Bool = false) {
        
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
    
    
    /// Wrapper function that takes a string link and transforms it to URL (if valid) and then uses the main downloaded function
    /// - Parameters:
    ///   - link: String URL
    ///   - cache: Images cache reference
    ///   - imageCacheId: Key reference that will be used for the downloaded iamge
    ///   - mode: Image content mode
    ///   - withTintColor: image tint color
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
