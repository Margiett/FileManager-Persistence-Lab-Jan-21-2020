//
//  FaveVC.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/23/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class FaveVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var favorite = [Pictures](){
        didSet{
            DispatchQueue.main.async {
                self.loadFaves()
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFaves()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func loadFaves() {
        do {
            favorite = try PersistenceHelper.loadPhotos().filter { $0.favedBy == "Margiett"}
        } catch {
            print("error")
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favorites" {
            guard let detailVC = segue.destination as? DetailVC, let indexPath = collectionView.indexPathsForSelectedItems?.first else {
                fatalError("segue did not work")
            }
            detailVC.selectedPhoto = favorite[indexPath.row]
        }
    }
}

extension FaveVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorite.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FaveCell", for: indexPath) as? FaveCVC else {
            fatalError("could not type cast cell")
        }
        let selectedPhoto = favorite[indexPath.row]
        cell.configureCell(for: selectedPhoto)
        cell.faveCellView = self
        return cell
    }
}

extension FaveVC: faveCell{
    func didLongPress(_ faveCell: FaveCVC) {
        guard let indexPath = collectionView.indexPath(for: faveCell) else {
            return
        }
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            self?.deleteImage(indexPath: indexPath)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    private func deleteImage(indexPath: IndexPath) {
        do {
            try PersistenceHelper.deletePhoto(photo: indexPath.row)
            favorite.remove(at: indexPath.row)
           
        } catch {
            print("delete error \(error)")
        }
        loadFaves()
}
}
extension FaveVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 3
        let totalSpace: CGFloat = numberOfItems * itemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpace) / numberOfItems
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
