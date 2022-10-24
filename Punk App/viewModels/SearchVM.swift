//
//  SearchVM.swift
//  Punk App
//
//  Created by Alejandro Miranda on 24/10/22.
//

import Foundation

class SearchVM: ObservableObject {
    @Published var beerList: [Beer] = []
    @Published var pending: Bool = true
    @Published var error: String? = nil

    @Published var lastPage: Bool = false
    
    private let beerService: BeerService = BeerService()
    
    func loadAllBeers(page: Int, filters: SearchFilter) {
        self.pending = true
        self.beerService.getAllBeers(page: page, filters: filters) { result in
            self.lastPage = false
            switch result {
            case .success(let data):
                self.beerList = data
            case .failure(let error):
                if error == .beersNotFound {
                    if !self.beerList.isEmpty {
                        self.lastPage = true
                    } else {
                        self.error = "We could not find any beer 😕"
                    }
                } else if error == .timeOut {
                    self.error = "Something went wrong, please try again ⚙️"
                }
            }
            self.pending = false
        }
    }
    
    func loadBeersByFood(food: String, page: Int, filters: SearchFilter) {
        self.pending = true
        self.beerService.searchBeerByFood(food: food, page: page, filters: filters) { result in
            self.lastPage = false
            switch result {
            case .success(let data):
                self.beerList = data
                if self.beerList.isEmpty {
                    self.error = "We could not find any beer 😕"
                }
            case .failure(let error):
                if error == .beersNotFound {
                    if !self.beerList.isEmpty {
                        self.lastPage = true
                    } else {
                        self.error = "We could not find any beer 😕"
                    }
                } else if error == .timeOut {
                    self.error = "Something went wrong, please try again ⚙️"
                }
            }
            self.pending = false
        }
    }
    
    func nextPageWithFoodText(food: String, page: Int, filters: SearchFilter) {
        self.beerService.searchBeerByFood(food: food, page: page, filters: filters) { result in
            self.lastPage = true
            switch result {
            case .success(let data):
                self.beerList.append(contentsOf: data)
            case .failure(let error):
                if error == .beersNotFound {
                    if !self.beerList.isEmpty {
                        self.lastPage = false
                    } else {
                        self.error = "We could not find any beer 😕"
                    }
                } else if error == .timeOut {
                    self.error = "Something went wrong, please try again ⚙️"
                }
            }
        }
    }
    
    func nextPage(page: Int, filters: SearchFilter) {
        self.beerService.getAllBeers(page: page, filters: filters){ result in
            self.lastPage = true
            switch result {
            case .success(let data):
                self.beerList.append(contentsOf: data)
            case .failure(let error):
                if error == .beersNotFound {
                    if !self.beerList.isEmpty {
                        self.lastPage = false
                    } else {
                        self.error = "We could not find any beer 😕"
                    }
                } else if error == .timeOut {
                    self.error = "Something went wrong, please try again ⚙️"
                }
            }
        }
    }
}
