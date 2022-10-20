//
//  BeerList.swift
//  Punk App
//
//  Created by Alejandro Miranda on 20/10/22.
//

import SwiftUI

struct BeerList: View {
    private let beerService: BeerService = BeerService()
    @State private var beerList: [Beer] = []
    @State private var error: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.$beerList, id: \.id) { beer in
                    BeerListItem(beer: beer)
                }
            }
            .navigationTitle("Results")
        }
        .onAppear {
            self.beerService.getAllBeers() { result in
                switch result {
                case .success(let data):
                    self.beerList = data
                case .failure(let error):
                    if error == .beersNotFound {
                        self.error = "We could not find any beer"
                    } else if error == .timeOut {
                        self.error = "Something went wrong, please try again"
                    }
                }
            }
        }
    }
}

struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        BeerList()
    }
}
