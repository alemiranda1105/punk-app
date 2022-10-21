//
//  SearchView.swift
//  Punk App
//
//  Created by Alejandro Miranda on 21/10/22.
//

import SwiftUI

struct SearchView: View {
    private let beerService: BeerService = BeerService()
    
    @State var searchText = ""
    @State var beerList: [Beer] = []
    @State var pending = false
    @State var error: String?
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: self.$searchText)
                    .onChange(of: searchText) { newValue in
                        if !newValue.isEmpty {
                            self.pending = true
                            self.beerService.searchBeerByFood(food: newValue) { result in
                                switch result {
                                case .success(let data):
                                    self.beerList = data
                                case .failure(let error):
                                    if error == .beersNotFound {
                                        self.error = "We could not find any beer 😕"
                                    } else if error == .timeOut {
                                        self.error = "Something went wrong, please try again ⚙️"
                                    }
                                }
                                self.pending = false
                            }
                        }
                    }
                if !pending && error == nil && beerList.count <= 0 {
                    Text("Start writing a food to find the best beer 🍻")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 25, weight: .light, design: .rounded))
                        .padding(.top, 20)
                }
            
                Spacer()
                
                if error != nil && !pending {
                    Text(error!)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                if pending {
                    ProgressView()
                }
                if !pending && error == nil {
                    BeerList(beerList: self.$beerList)
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
