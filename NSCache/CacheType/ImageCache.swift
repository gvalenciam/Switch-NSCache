//
//  ImageCache.swift
//  NSCache
//
//  Created by Gerardo Valencia on 4/06/22.
//

import Foundation
import UIKit

class ImageCache: NSObject, ImageCacheType {
    
    struct Config {
        
        let countLimit: Int
        let memoryLimit: Int
        
        static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100)
        
    }
    
    private let config: Config
    
    
    /// Images cache variable
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = self.config.countLimit
        return cache
    }()
    
    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
    
    // MARK: IMAGE CACHE TYPE PROTOCOL
    func image(for url: URL) -> UIImage? {
        
        if let image = self.imageCache.object(forKey: url as AnyObject) as? UIImage {
            return image
        } else {
            return nil
        }
        
    }
    
    func insertImage(_ image: UIImage?, for url: URL) {
        
        if let image = image {
            self.imageCache.setObject(image, forKey: url as AnyObject)
        } else {
            return self.removeImage(for: url)
        }
        
    }
    
    func removeImage(for url: URL) {
        self.imageCache.removeObject(forKey: url as AnyObject)
    }
    
    func removeAllImages() {
        self.imageCache.removeAllObjects()
    }
    
    subscript(url: URL) -> UIImage? {
        
        get {
            return image(for: url)
        }
        
        set {
            return self.insertImage(newValue, for: url)
        }
        
    }
    
}
