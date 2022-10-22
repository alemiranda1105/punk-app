//
//  BeerList.swift
//  Punk App
//
//  Created by Alejandro Miranda on 20/10/22.
//

import SwiftUI

struct BeerList: View {
    @Binding var beerList: [Beer]
    @Binding var pageNumber: Int
    @Binding var lastPage: Bool
    
    var body: some View {
        List {
            ForEach(self.$beerList, id: \.id) { beer in
                BeerListItem(beer: beer)
            }
            if !self.lastPage {
                Button(action: {
                    self.pageNumber += 1
                }) {
                    HStack {
                        Text("View more")
                        Image(systemName: "chevron.down")
                    }
                }
            }
        }
    }
}

struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        BeerList(beerList: .constant(mockBeerList), pageNumber: .constant(1), lastPage: .constant(true))
    }
}
