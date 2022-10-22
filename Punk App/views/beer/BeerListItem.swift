//
//  BeerListItem.swift
//  Punk App
//
//  Created by Alejandro Miranda on 20/10/22.
//

import SwiftUI

struct BeerListItem: View {
    @Binding var beer: Beer
    var body: some View {
        NavigationLink(destination: BeerDetails(beer: self.$beer)) {
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: self.beer.image_url)) { image in
                    image
                        .resizable()
                        .interpolation(.none)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 64, height: 64, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                VStack(alignment: .leading) {
                    Text(self.beer.name)
                        .font(.title3.weight(.bold))
                    Text(self.beer.description)
                        .font(.callout)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                    
                }
                .padding(.horizontal)
            }
        }
        .buttonStyle(.plain)
    }
}

struct BeerListItem_Previews: PreviewProvider {
    static var previews: some View {
        BeerListItem(beer: .constant(mockBeer))
    }
}
