//
//  NSCacheTableViewCell.swift
//  NSCache
//
//  Created by Gerardo Valencia on 4/06/22.
//

import UIKit

class NSCacheTableViewCell: UITableViewCell {
    
    // MARK: IDENTIFIER
    static let identifier = "NSCacheTableViewCell"
    
    // MARK: VARIABLES
    var model: NSCacheImageModel = NSCacheImageModel()
    var imagesCache: ImageCache = ImageCache()
    
    // MARK: UI ELEMENTS
    var image: UIImageView = UIImageView()
    var titleSubtitleStackView: UIStackView = UIStackView()
    var titleLabel: UILabel = UILabel()
    var subtitleLabel: UILabel = UILabel()
    var deleteImageFromCacheButton: UIButton = UIButton()

    func setupUI() {
        
        self.contentView.addSubview(self.image)
        self.image.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(15)
            make.top.bottom.equalTo(self.contentView).inset(15)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        self.titleSubtitleStackView.axis = .vertical
        self.titleSubtitleStackView.alignment = .leading
        self.titleSubtitleStackView.distribution = .fill
        self.titleSubtitleStackView.spacing = 5
        self.contentView.addSubview(self.titleSubtitleStackView)
        self.titleSubtitleStackView.snp.makeConstraints { make in
            make.left.equalTo(self.image.snp.right).offset(15)
            make.centerY.equalTo(self.contentView)
        }
        
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 17)
        self.titleSubtitleStackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self.titleSubtitleStackView)
        }
        
        self.subtitleLabel.textColor = .black
        self.subtitleLabel.font = .systemFont(ofSize: 15)
        self.titleSubtitleStackView.addArrangedSubview(self.subtitleLabel)
        self.subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self.titleSubtitleStackView)
        }
        
        self.deleteImageFromCacheButton.backgroundColor = .red
        self.deleteImageFromCacheButton.tintColor = .white
        self.deleteImageFromCacheButton.layer.cornerRadius = 17.5
        self.deleteImageFromCacheButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        self.deleteImageFromCacheButton.setImage(UIImage(systemName: "trash"), for: .normal)
        self.deleteImageFromCacheButton.addTarget(self, action: #selector(self.deleteImageFromCache), for: .touchUpInside)
        self.contentView.addSubview(self.deleteImageFromCacheButton)
        self.deleteImageFromCacheButton.snp.makeConstraints { make in
            make.left.equalTo(self.titleSubtitleStackView.snp.right).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
        
    }
    
    func configure(withModel model: NSCacheImageModel, andCache imagesCache: ImageCache) {
        
        self.setupUI()
        
        self.model = model
        self.imagesCache = imagesCache
        self.titleLabel.text = model.title
        self.subtitleLabel.text = model.subtitle
        
        // Check Cache
        // If image is already saved on cache, set image directly on image view
        // else download image and save it to cache
        if let cacheImageURL = model.createCacheImageURL() {
            
            if let image = imagesCache[cacheImageURL] {
                print("USING CACHED IMAGE WITH ID: \(cacheImageURL)")
                self.image.image = image
            } else {
                print("DOWNLOADING IMAGE TO CACHE WITH ID: \(cacheImageURL)")
                self.image.downloaded(from: model.imageURL, withCache: imagesCache, imageCacheId: cacheImageURL)
            }
            
        }
        
    }
    
    @objc func deleteImageFromCache() {
        
        if let cacheImageURL = self.model.createCacheImageURL() {
            print("DELETING IMAGE FROM CACHE WITH URL: \(cacheImageURL.absoluteString)")
            self.imagesCache.removeImage(for: cacheImageURL)
        }
        
    }
    
    override func prepareForReuse() {
        self.image.removeFromSuperview()
        self.image = UIImageView()
        self.titleSubtitleStackView.removeFromSuperview()
        self.titleSubtitleStackView = UIStackView()
        self.titleLabel.removeFromSuperview()
        self.titleLabel = UILabel()
        self.subtitleLabel.removeFromSuperview()
        self.subtitleLabel = UILabel()
    }

}
