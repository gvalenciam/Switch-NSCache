//
//  NSCacheImageModel.swift
//  NSCache
//
//  Created by Gerardo Valencia on 4/06/22.
//

import Foundation

class NSCacheImageModel {
    
    var cacheId: String = ""
    var imageURL: String = ""
    var title: String = ""
    var subtitle: String = ""
    
    init(cacheId: String = "", imageURL: String = "", title: String = "", subtitle: String = "") {
        self.cacheId = cacheId
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
    }
    
    // MARK: UTILS
    
    /// Function that creates an image ID from imageURL + imageCacheId that will be used as key for the iamges cache
    /// - Returns: image URL for cache
    func createCacheImageURL() -> URL? {
        
        if let completeImageURL = URL(string: (self.imageURL + self.cacheId)) {
            return completeImageURL
        } else {
            return nil
        }
        
    }
    
}
