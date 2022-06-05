//
//  ImageCacheType.swift
//  NSCache
//
//  Created by Gerardo Valencia on 4/06/22.
//

import Foundation
import UIKit

protocol ImageCacheType: AnyObject {
    
    // Return image with url as key
    func image(for url: URL) -> UIImage?
    
    // Add image with the given url (key) in the cache
    func insertImage(_ image: UIImage?, for url: URL)
    
    // Remove the image with the given url (key) from cache
    func removeImage(for url: URL)
    
    // Remove all images from cache
    func removeAllImages()
    
    // Acces the values with the given key (similar to dictionary)
    subscript(_ url: URL) -> UIImage? { get set }
    
}
