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
    @State var searchFilters = SearchFilter()
    
    @State var beerList: [Beer] = []
    @State var pending = true
    @State var error: String?
    
    @State var currentPage: Int = 1
    @State var lastPage = false
    
    private func loadAllBeers() {
        self.pending = true
        self.beerService.getAllBeers(page: currentPage, filters: searchFilters) { result in
            lastPage = false
            switch result {
            case .success(let data):
                self.beerList = data
            case .failure(let error):
                if error == .beersNotFound {
                    if !self.beerList.isEmpty {
                        lastPage = true
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
    
    private func loadBeersByFood(food: String, page: Int) {
        self.pending = true
        self.beerService.searchBeerByFood(food: food, page: page, filters: searchFilters) { result in
            lastPage = false
            switch result {
            case .success(let data):
                self.beerList = data
                if self.beerList.isEmpty {
                    self.error = "We could not find any beer 😕"
                }
            case .failure(let error):
                if error == .beersNotFound {
                    if !self.beerList.isEmpty {
                        lastPage = true
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
    
    private func nextPageWithFoodText(food: String, page: Int) {
        self.beerService.searchBeerByFood(food: food, page: page, filters: searchFilters) { result in
            lastPage = true
            switch result {
            case .success(let data):
                self.beerList.append(contentsOf: data)
            case .failure(let error):
                if error == .beersNotFound {
                    if !self.beerList.isEmpty {
                        lastPage = false
                    } else {
                        self.error = "We could not find any beer 😕"
                    }
                } else if error == .timeOut {
                    self.error = "Something went wrong, please try again ⚙️"
                }
            }
        }
    }
    
    private func nextPage(page: Int) {
        self.beerService.getAllBeers(page: page, filters: searchFilters){ result in
            lastPage = true
            switch result {
            case .success(let data):
                self.beerList.append(contentsOf: data)
            case .failure(let error):
                if error == .beersNotFound {
                    if !self.beerList.isEmpty {
                        lastPage = false
                    } else {
                        self.error = "We could not find any beer 😕"
                    }
                } else if error == .timeOut {
                    self.error = "Something went wrong, please try again ⚙️"
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if error != nil && !pending {
                    Text(error!)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                
                if pending {
                    ProgressView()
                }
                
                if !pending && error == nil && !beerList.isEmpty {
                    BeerList(beerList: self.$beerList, pageNumber: self.$currentPage, lastPage: self.$lastPage)
                        .onChange(of: currentPage) { newValue in
                            if searchText.isEmpty {
                                nextPage(page: newValue)
                            } else {
                                nextPageWithFoodText(food: searchText, page: newValue)
                            }
                        }
                }
                
            }
            .navigationTitle("Search")
            .toolbar {
                if !beerList.isEmpty {
                    ToolbarItem {
                        SearchFiltersView(searchFilters: self.$searchFilters)
                            .onChange(of: searchFilters) { _ in
                                if searchText.isEmpty {
                                    loadAllBeers()
                                } else {
                                    loadBeersByFood(food: searchText, page: currentPage)
                                }
                            }
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                if !newValue.isEmpty {
                    loadBeersByFood(food: newValue, page: currentPage)
                }
            }
        }
        .onAppear {
            loadAllBeers()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
