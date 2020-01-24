//
//  PhotoCellCollectionViewCell.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/22/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import ImageKit

class PhotoCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    
    public func PhotoConfigureCell(for pic: Pictures) {
        print("hi")
        
//        let imageURL = "https://pixabay.com/api/?key=14991998-9d3da7e6735e6158dc94cd4b2&q="
        
        photoImage.getImage(with: pic.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.photoImage.image = UIImage(systemName: "exclamationmark-triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.photoImage.image = image
                }
            }
        }
        
    }
    
}
