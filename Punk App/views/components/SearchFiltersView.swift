//
//  SearchFiltersView.swift
//  Punk App
//
//  Created by Alejandro Miranda on 23/10/22.
//

import SwiftUI

struct SearchFiltersView: View {
    @Binding var searchFilters: SearchFilter
    
    @State var showFilters = false
    @State var filtersApplied = false
    
    var body: some View {
        Button(action: {
            self.showFilters = true
        }) {
            HStack {
                Text("Filters")
                Image(systemName: "line.horizontal.3.decrease.circle")
            }
        }
        .padding(3)
        .background(
            filtersApplied ? Color(.systemBlue) : nil
        )
        .foregroundColor(
            filtersApplied ? .white : .accentColor
        )
        .cornerRadius(10)
        .sheet(isPresented: $showFilters) {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.showFilters = false
                    }) {
                        Text("Close")
                    }
                }
                .padding()
                
                Text("Filters")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                
                VStack {
                    VStack {
                        Text("ABV: \(searchFilters.abv_lt.description)")
                            .bold()
                        Slider(value: $searchFilters.abv_lt,
                               in: 0...100,
                               step: 0.25,
                               onEditingChanged: { _ in
                                filtersApplied = searchFilters.abv_lt < 100
                               },
                               minimumValueLabel: Text("0"),
                               maximumValueLabel: Text("100")
                        ) {
                                Text("ABV")
                        }
                    }.padding()
                    DatePicker(selection: $searchFilters.brewed_before, in: ...Date(), displayedComponents: .date) {
                        Text("First brewed")
                            .bold()
                    }
                    .padding()
                    .onChange(of: searchFilters.brewed_before) { _ in
                        filtersApplied = searchFilters.brewed_before < Date()
                    }
                    
                    if filtersApplied {
                        Button(action: {
                            searchFilters.clearFilters()
                            self.filtersApplied = false
                            self.showFilters = false
                        }) {
                            Text("Clear filters")
                                .bold()
                        }
                        .padding(8)
                        .background(Color(.systemGray3))
                        .foregroundColor(.red)
                        .cornerRadius(6)
                        .padding(.top, 65)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct SearchFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchFiltersView(searchFilters: .constant(SearchFilter()))
            SearchFiltersView(searchFilters: .constant(SearchFilter()), showFilters: true)
        }
    }
}
