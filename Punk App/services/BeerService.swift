//
//  BeerService.swift
//  Punk App
//
//  Created by Alejandro Miranda on 20/10/22.
//

import Foundation
import Combine
import SwiftUI

enum BeerServiceError: Error {
    case beersNotFound
    case timeOut
}

struct BeerService {
    private let API_URL: URL = URL(string: "https://api.punkapi.com/v2/beers")!
    
    public func getAllBeers(_page: Int = 1, _maxPages: Int = 10, _itemsPerPage: Int = 20, completionHandler: @escaping (Result<[Beer], BeerServiceError>) -> ()) {
        var request = URLRequest(url: self.API_URL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
                completionHandler(.failure(BeerServiceError.beersNotFound))
                return
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Beer].self, from: data!)
                DispatchQueue.main.async {
                    completionHandler(.success(decodedData))
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completionHandler(.failure(BeerServiceError.beersNotFound))
                }
            }
        }.resume()
    }
}
