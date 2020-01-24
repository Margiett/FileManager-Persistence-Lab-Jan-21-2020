//
//  FaveCVC.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/23/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

protocol faveCell: AnyObject {
    func didLongPress(_ faveCell: FaveCVC)

}
class FaveCVC: UICollectionViewCell {
    
    @IBOutlet weak var imagePhoto: UIImageView!
    
    weak var faveCellView: faveCell?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
          let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
          return gesture

      } ()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGestureRecognizer(longPressGesture)
    }
    
    @objc
    private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began{
            gesture.state = .cancelled
            return
        }
        faveCellView?.didLongPress(self)
    }
    
    func configureCell(for fave: Pictures) {
        print("testing")
        imagePhoto.getImage(with: fave.largeImageURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.imagePhoto.image = UIImage(systemName: "photo.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imagePhoto.image = image
                }
            }
            
        }
    }
    
}
