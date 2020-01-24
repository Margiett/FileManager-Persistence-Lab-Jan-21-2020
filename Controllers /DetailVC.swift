//
//  DetailVC.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/22/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import ImageKit

class DetailVC: UIViewController {
    @IBOutlet weak var imagePic: UIImageView!
    @IBOutlet weak var favButton: UIBarButtonItem!
    
    
    var selectedPhoto: Pictures?
    var favorite = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        guard let photoData = selectedPhoto else {
            fatalError("segue did not work")
        }
        
        
        let imageURL = "https://pixabay.com/api/?key=14991998-9d3da7e6735e6158dc94cd4b2&q="
        
        
        imagePic.getImage(with: imageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imagePic.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imagePic.image = image
                }
            }
        }
    }
    @IBAction func addToFaves(_sender: UIBarButtonItem) {
        guard let fav = selectedPhoto else {
            return
        }
        let fave = Pictures(largeImageURL: fav.largeImageURL, likes: fav.likes, views: fav.views, comments: fav.comments, downloads: fav.downloads, user: fav.user, previewURL: fav.previewURL, webformatURL: fav.webformatURL, favorites: fav.favorites, favedBy: "Margiett", tags: fav.tags)
        
        favorite.toggle()
        
    }
}
