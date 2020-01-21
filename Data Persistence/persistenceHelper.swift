//
//  persistenceHelper.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/21/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
enum DataPersistenceError: Error{
    case savingError(Error) // associated value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    
    private static var photos = [Pictures]()
    private static let filename = "photo.plist"
    private static func save() throws {
        
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        do {
            let data = try PropertyListEncoder().encode(photos)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    static func save(photo: Pictures) throws {
        photos.append(photo)
        do{
            try save()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    static func loadEvents() throws -> [Pictures] {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    try photos = PropertyListDecoder().decode([Pictures].self, from: data)
                } catch {
                    throw DataPersistenceError.decodingError(error)
                }
            } else {
                print("Data not found")
                throw DataPersistenceError.noData
            }
        } else{
            print("\(filename) does not exist.")
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
        return photos
    }
    
    static func delete(photo index: Int) throws {
        photos.remove(at: index)
        do {
            try save()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}
