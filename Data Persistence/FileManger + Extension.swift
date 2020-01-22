//
//  FileManger + Extension.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/21/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

extension FileManager {
    static func getDocumentsDirectory() -> URL {
       return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    static func pathToDocumentsDirectory(with fileName: String) -> URL {
        
        return getDocumentsDirectory().appendingPathComponent(fileName)
    }
}

//MARK: URLSession gives you access to the internet
//MARK: FileManger: is interface to the contain of the file system. which allows you to create, read, update, and delete. update on def
//MARK: .userDomainMask: making a personal folder to save the information.
