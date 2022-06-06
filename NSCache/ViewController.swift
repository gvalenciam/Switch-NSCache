//
//  ViewController.swift
//  NSCache
//
//  Created by Gerardo Valencia on 24/05/22.
//

import SnapKit
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: UI ELEMENTS

    let tableView: UITableView = .init()
    private let tableViewRefreshControl = UIRefreshControl()
    
    // MARK: TABLE IMAGES CACHE

    let imagesCache: ImageCache = .init()
    
    // MARK: MODELS

    let models: [NSCacheImageModel] = [
        NSCacheImageModel(cacheId: "Image_1", imageURL: RANDOM_URL_1, title: "Title Image 1", subtitle: "Subtitle Image 1"),
        NSCacheImageModel(cacheId: "Image_2", imageURL: RANDOM_URL_2, title: "Title Image 2", subtitle: "Subtitle Image 2"),
        NSCacheImageModel(cacheId: "Image_3", imageURL: RANDOM_URL_3, title: "Title Image 3", subtitle: "Subtitle Image 3"),
        NSCacheImageModel(cacheId: "Image_4", imageURL: RANDOM_URL_4, title: "Title Image 4", subtitle: "Subtitle Image 4"),
        NSCacheImageModel(cacheId: "Image_5", imageURL: RANDOM_URL_5, title: "Title Image 5", subtitle: "Subtitle Image 5")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = .white
        self.tableView.separatorStyle = .none
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
                    
        self.tableView.register(NSCacheTableViewCell.self,
                                forCellReuseIdentifier: NSCacheTableViewCell.identifier)
        self.tableView.refreshControl = self.tableViewRefreshControl
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Refresh control
        self.tableViewRefreshControl.tintColor = .black
        self.tableViewRefreshControl.attributedTitle = NSAttributedString(string: "Reloading")
        self.tableViewRefreshControl.addTarget(self, action: #selector(self.refreshTableView), for: .valueChanged)
    }
    
    // MARK: UI ACTIONS
    
    /// Function triggered when table view is pulled down (pull to refresh)
    @objc func refreshTableView() {
        self.tableView.reloadData()
        
        if self.tableViewRefreshControl.isRefreshing {
            self.tableViewRefreshControl.endRefreshing()
        }
    }
    
    // MARK: TABLE VIEW SOURCE & DELEGATE

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    /// Function that deletes the image from the cache for the given cell.
    /// - Parameters:
    ///   - tableView: VC table view
    ///   - editingStyle: delete (swipe right to left)
    ///   - indexPath: index for cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let cell = tableView.cellForRow(at: indexPath) as? NSCacheTableViewCell {
                cell.deleteImageFromCache()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NSCacheTableViewCell.identifier,
            for: indexPath
        ) as? NSCacheTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.configure(withModel: self.models[indexPath.row], andCache: self.imagesCache)
        
        return cell
    }
}
