//
//  BeerList.swift
//  Punk App
//
//  Created by Alejandro Miranda on 20/10/22.
//

import SwiftUI

struct BeerList: View {
    @Binding var beerList: [Beer]
    
    var body: some View {
        List {
            ForEach(self.$beerList, id: \.id) { beer in
                BeerListItem(beer: beer)
            }
        }
    }
}

struct BeerList_Previews: PreviewProvider {
    static var previews: some View {
        BeerList(beerList: .constant(mockBeerList))
    }
}
