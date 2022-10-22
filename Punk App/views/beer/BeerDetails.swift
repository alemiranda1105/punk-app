//
//  BeerDetails.swift
//  Punk App
//
//  Created by Alejandro Miranda on 22/10/22.
//

import SwiftUI

struct BeerDetails: View {
    @Binding var beer: Beer
    var body: some View {
        List {
            Section {
                VStack {
                    AsyncImage(url: URL(string: beer.image_url)) { image in
                        image
                            .resizable()
                            .interpolation(.none)
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(maxWidth: .infinity, maxHeight: 250, alignment: .center)
                    .padding()
                    
                    Text(beer.name)
                        .font(.system(size: 45))
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                }
            }
            
            Section {
                VStack(alignment: .leading, spacing: 24) {
                    BeerDetailsSection(sectionTitle: "Description", sectionBody: beer.description)
                    BeerDetailsSection(sectionTitle: "First brewed", sectionBody: beer.first_brewed)
                }
            }
            
            Section {
                VStack(alignment: .leading, spacing: 24) {
                    if beer.brewers_tips != nil {
                        BeerDetailsSection(sectionTitle: "Tips", sectionBody: beer.brewers_tips!)
                    }
                    
                    if beer.food_pairing != nil {
                        Text("Food pairing")
                            .font(.system(size: 32.5))
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ForEach(beer.food_pairing!, id:\.self) { food in
                                Text("⚫️ \(food)")
                                    .font(.system(size: 18))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
            }
            
            Section {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Values")
                        .font(.system(size: 32.5))
                        .fontWeight(.bold)
                        .fixedSize(horizontal: false, vertical: true)
                    if beer.abv != nil {
                        ValuesSectionItem(sectionTitle: "ABV", sectionBody: beer.abv!.description)
                    }
                    
                    if beer.ibu != nil {
                        ValuesSectionItem(sectionTitle: "IBU", sectionBody: beer.ibu!.description)
                    }
                    
                    if beer.ph != nil {
                        ValuesSectionItem(sectionTitle: "PH", sectionBody: beer.ph!.description)
                    }
                    
                    if beer.attenuation_level != nil {
                        ValuesSectionItem(sectionTitle: "Attenuation level", sectionBody: beer.attenuation_level!.description)
                    }
                    
                    if beer.boil_volume != nil {
                        ValuesSectionItem(sectionTitle: "Boil volume", sectionBody: beer.boil_volume!.description)
                    }
                }
            }
            
            if beer.ingredients != nil {
                Section {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Ingredients")
                            .font(.system(size: 32.5))
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        IngredientsList(ingredients: .constant(beer.ingredients!))
                    }
                }
            }
            
            if beer.method != nil {
                Section {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Method")
                            .font(.system(size: 32.5))
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                        let method = beer.method!
                        if method.mash_temp != nil {
                            VStack {
                                ForEach(method.mash_temp!, id: \.duration) { mash in
                                    ValuesSectionItem(sectionTitle: "Mash temp", sectionBody: mash.temp!.description)
                                }
                            }
                        }
                        
                        if method.fermentation != nil {
                            ValuesSectionItem(sectionTitle: "Fermentation", sectionBody: method.fermentation!.temp!.description)
                        }
                    }
                }
            }
            
            Text("Contributed by \(beer.contributed_by ?? "unknown")")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(Color(.systemGray))
            
        }
        .navigationTitle("Details")
    }
}

struct BeerDetails_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetails(beer: .constant(mockBeer))
    }
}
