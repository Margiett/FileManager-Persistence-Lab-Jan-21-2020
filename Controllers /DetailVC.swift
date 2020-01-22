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

    override func viewDidLoad() {
        super.viewDidLoad()
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
}
