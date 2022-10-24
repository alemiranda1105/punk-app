//
//  BeerDetailsVM.swift
//  Punk App
//
//  Created by Alejandro Miranda on 24/10/22.
//

import Foundation

class BeerDetailsVM: ObservableObject {
    @Published var beer: Beer?
    @Published var pending: Bool = true
    @Published var error: String? = nil
    
    let beerId: Int
    
    private let beerService = BeerService()
    
    init(beerId: Int) {
        self.beerId = beerId
    }
    
    
    func loadBeerDetails() {
        self.pending = true
        self.beerService.getBeerById(beerId: self.beerId) { result in
            switch result {
            case .success(let data):
                self.beer = data
            case .failure(let error):
                if error == .beersNotFound {
                    self.error = "We could not find any beer 😕"
                } else if error == .timeOut {
                    self.error = "Something went wrong, please try again ⚙️"
                }
                self.beer = nil
            }
            self.pending = false
        }
    }
}
