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
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var previewURLLabel: UILabel!
    @IBOutlet weak var webformatURLLabel: UILabel!
    
    
    var selectedPhoto: Pictures?
    var favorited = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){

        //MARK: Labels
        likesLabel.text = "Likes: \(selectedPhoto?.likes ?? 1)"
        favoritesLabel.text = "Favorited: \(selectedPhoto?.favorites ?? 1)"
        previewURLLabel.text = "preview: \(selectedPhoto?.previewURL ?? "")"
        webformatURLLabel.text = selectedPhoto?.webformatURL
        let tags = selectedPhoto?.tags.components(separatedBy: ", ")
        let hashtags = tags?.joined(separator: " #")
        tagsLabel.text = "#\(hashtags ?? "")"
        
        
        //MARK: Picture !
        imagePic.getImage(with: selectedPhoto!.largeImageURL) { [weak self] (result) in
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
    @IBAction func addToFaves(_ sender: UIBarButtonItem) {
        guard let fav = selectedPhoto else {
            showAlert(title: "App Error", message: "Issue uploading data")
            return
        }
        
        showAlert(title: "❤️", message: "This picture was added to your favorites")
        let fave = Pictures(largeImageURL: fav.largeImageURL, likes: fav.likes, views: fav.views, comments: fav.comments, downloads: fav.downloads, user: fav.user, previewURL: fav.previewURL, webformatURL: fav.webformatURL, favorites: fav.favorites, favedBy: "Margiett", tags: fav.tags)
        do {
            try PersistenceHelper.save(photo: fave)
            
        } catch {
            print("\(error)")
        }
        
    }
}
