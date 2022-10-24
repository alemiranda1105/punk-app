//
//  SearchView.swift
//  Punk App
//
//  Created by Alejandro Miranda on 21/10/22.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchVM = SearchVM()
    
    @State var searchText = ""
    @State var searchFilters = SearchFilter()
    
    @State var currentPage: Int = 1
    
    var body: some View {
        NavigationView {
            VStack {
                if searchVM.error != nil && !searchVM.pending {
                    Text(searchVM.error!)
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                
                if searchVM.pending {
                    ProgressView()
                }
                
                if !searchVM.pending && searchVM.error == nil && !searchVM.beerList.isEmpty {
                    BeerList(beerList: self.$searchVM.beerList, pageNumber: self.$currentPage, lastPage: self.$searchVM.lastPage)
                        .onChange(of: currentPage) { newValue in
                            if searchText.isEmpty {
                                self.searchVM.nextPage(page: newValue, filters: searchFilters)
                            } else {
                                self.searchVM.nextPageWithFoodText(food: searchText, page: newValue, filters: searchFilters)
                            }
                        }
                }
                
            }
            .navigationTitle("Search")
            .toolbar {
                if !self.searchVM.beerList.isEmpty {
                    ToolbarItem {
                        SearchFiltersView(searchFilters: self.$searchFilters)
                            .onChange(of: searchFilters) { _ in
                                if searchText.isEmpty {
                                    self.searchVM.loadAllBeers(page: self.currentPage, filters: self.searchFilters)
                                } else {
                                    self.searchVM.loadBeersByFood(food: searchText, page: currentPage, filters: searchFilters)
                                }
                            }
                    }
                }
            }
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                if !newValue.isEmpty {
                    self.searchVM.loadBeersByFood(food: newValue, page: currentPage, filters: searchFilters)
                } else {
                    self.searchVM.loadAllBeers(page: self.currentPage, filters: self.searchFilters)
                }
            }
        }
        .onAppear {
            self.searchVM.loadAllBeers(page: self.currentPage, filters: self.searchFilters)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
