//
//  APIClient.swift
//  FileManager Persistence Lab Jan 21 2020
//
//  Created by Margiett Gil on 1/21/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import NetworkHelper

struct PhotoAPIClient {
    static func fetchPhoto(for searchQuery: String, completion: @escaping (Result<[Pictures], AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        let endPointURL = "https://pixabay.com/api/?key=14991998-9d3da7e6735e6158dc94cd4b2&q=\(searchQuery)"
        guard let url = URL(string: endPointURL) else {completion(.failure(.badURL(endPointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {
            (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success(let data):
                    do {
                        let searchResult = try
                            JSONDecoder().decode(Photos.self, from: data)
                        completion(.success(searchResult.hits))
                    } catch {
                        completion(.failure(.decodingError(error)))
                    }
            }
        }
    
    }
}
