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
    private let API_URL: String = "https://api.punkapi.com/v2/beers"
    private let itemsPerPage: Int = 20
    
    public func getAllBeers(page: Int, filters: SearchFilter, completionHandler: @escaping (Result<[Beer], BeerServiceError>) -> ()) {
        var request = URLRequest(url: URL(string: "\(API_URL)?page=\(page)&per_page=\(itemsPerPage)&\(filters.description)")!)
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
    
    public func searchBeerByFood(food: String, page: Int, filters: SearchFilter, completionHandler: @escaping (Result<[Beer], BeerServiceError>) -> ()) {
        var request = URLRequest(url: URL(string: "\(API_URL)?food=\(food)&page=\(page)&per_page=\(itemsPerPage)&\(filters.description)")!)
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
