//
//  Model.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/21/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

struct Photots: Codable{
    let hits: [Pictures]
}

struct Pictures: Codable{
    let largeImageURL: String
    let likes: Int
    let views: Int
    let comments: Int?
    let downloads: Int
    let user: String
    let previewURL: String
}
