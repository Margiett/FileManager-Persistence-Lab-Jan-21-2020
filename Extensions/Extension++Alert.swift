//
//  Extension++Alert.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/27/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
extension UIViewController {
  func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}

