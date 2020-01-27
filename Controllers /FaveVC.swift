//
//  FaveVC.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/23/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class FaveVC: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    
    var favorite = [Pictures]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        loadFaves()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        loadFaves()
//    }
    //MARK: loadsFaves()
    func loadFaves() {
        do {
            favorite = try PersistenceHelper.loadPhotos().filter { $0.favedBy == "Margiett"}
        } catch {
            print("error")
        }
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
        }
    }
}
//MARK: DataSource
extension FaveVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FaveCell", for: indexPath) as? FaveCVC else {
            fatalError("could not type cast cell")
        }
        let selectedPhoto = favorite[indexPath.row]
        cell.configureCell(for: selectedPhoto)
        cell.faveCellView = self
        return cell
    }
}
//MARK: Delegate 
extension FaveVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
    
//MARK: LongPress
extension FaveVC: faveCell{
    func didLongPress(_ faveCell: FaveCVC) {
        guard let indexPath = favoriteTableView.indexPath(for: faveCell) else {
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
