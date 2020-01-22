//
//  ViewController.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/21/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photoCollection: UICollectionView!
    
    var photos = [Pictures]()
    
    var searchQuery = "photo" {
        didSet{
            searchPhoto()
        }
    }
    
    var photoDidSet = [Pictures]() {
        didSet{
            DispatchQueue.main.async {
                self.photoCollection.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func searchPhoto(){
        PhotoAPIClient.fetchPhoto(for: "\(searchQuery)", completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let photos):
                self?.photoDidSet = photos
            }
        })
    }


}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchQuery = searchBar.text!
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoDidSet.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCellCollectionViewCell else {
            fatalError("Could not type cast reusable cell")
        }
        let photoImage = photoDidSet[indexPath.row]
        cell.configureCell(for: photoImage)
        return cell
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let interItemSpacing = CGFloat(1)
            let maxWidth = UIScreen.main.bounds.size.width // device's width
    //      let maxHeight = UIScreen.main.bounds.size.height
            let numberOfItems: CGFloat = 1 // items per row
            let totalSpacing: CGFloat = numberOfItems * interItemSpacing
            let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
            
            //this sizing is so it prints squares.
            return CGSize(width: itemWidth, height: itemWidth)
        }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            
            return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
}
