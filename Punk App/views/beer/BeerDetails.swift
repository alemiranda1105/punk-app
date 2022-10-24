//
//  BeerDetails.swift
//  Punk App
//
//  Created by Alejandro Miranda on 22/10/22.
//

import SwiftUI

struct BeerDetails: View {
    let beerId: Int
    @StateObject var beerDetailsVM: BeerDetailsVM
    
    
    init(beerId: Int) {
        self.beerId = beerId
        _beerDetailsVM = StateObject(wrappedValue: BeerDetailsVM(beerId: beerId))
    }

    var body: some View {
        List {
            if self.beerDetailsVM.pending {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            
            if self.beerDetailsVM.error != nil && !self.beerDetailsVM.pending {
                Text(self.beerDetailsVM.error!)
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            
            if !self.beerDetailsVM.pending && self.beerDetailsVM.beer != nil {
                Section {
                    VStack {
                        AsyncImage(url: URL(string: beerDetailsVM.beer!.image_url)) { image in
                            image
                                .resizable()
                                .interpolation(.none)
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray
                        }
                        .frame(maxWidth: .infinity, maxHeight: 250, alignment: .center)
                        .padding()
                        
                        Text(beerDetailsVM.beer!.name)
                            .font(.system(size: 45))
                            .fontWeight(.black)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 24) {
                        BeerDetailsSection(sectionTitle: "Description", sectionBody: beerDetailsVM.beer!.description)
                        BeerDetailsSection(sectionTitle: "First brewed", sectionBody: beerDetailsVM.beer!.first_brewed)
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 24) {
                        if beerDetailsVM.beer?.brewers_tips != nil {
                            BeerDetailsSection(sectionTitle: "Tips", sectionBody: beerDetailsVM.beer!.brewers_tips!)
                        }
                        
                        if beerDetailsVM.beer!.food_pairing != nil {
                            Text("Food pairing")
                                .font(.system(size: 32.5))
                                .fontWeight(.bold)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(beerDetailsVM.beer!.food_pairing!, id:\.self) { food in
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
                        if beerDetailsVM.beer!.abv != nil {
                            ValuesSectionItem(sectionTitle: "ABV", sectionBody: beerDetailsVM.beer!.abv!.description)
                        }
                        
                        if beerDetailsVM.beer!.ibu != nil {
                            ValuesSectionItem(sectionTitle: "IBU", sectionBody: beerDetailsVM.beer!.ibu!.description)
                        }
                        
                        if beerDetailsVM.beer!.ph != nil {
                            ValuesSectionItem(sectionTitle: "PH", sectionBody: beerDetailsVM.beer!.ph!.description)
                        }
                        
                        if beerDetailsVM.beer!.attenuation_level != nil {
                            ValuesSectionItem(sectionTitle: "Attenuation level", sectionBody: beerDetailsVM.beer!.attenuation_level!.description)
                        }
                        
                        if beerDetailsVM.beer!.boil_volume != nil {
                            ValuesSectionItem(sectionTitle: "Boil volume", sectionBody: beerDetailsVM.beer!.boil_volume!.description)
                        }
                    }
                }
                
                if beerDetailsVM.beer!.ingredients != nil {
                    Section {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Ingredients")
                                .font(.system(size: 32.5))
                                .fontWeight(.bold)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            IngredientsList(ingredients: .constant(beerDetailsVM.beer!.ingredients!))
                        }
                    }
                }
                
                if beerDetailsVM.beer!.method != nil {
                    Section {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Method")
                                .font(.system(size: 32.5))
                                .fontWeight(.bold)
                                .fixedSize(horizontal: false, vertical: true)
                            let method = beerDetailsVM.beer!.method!
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
                
                Text("Contributed by \(beerDetailsVM.beer!.contributed_by ?? "unknown")")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color(.systemGray))
            }
        }
        .navigationTitle("Details")
        .onAppear {
            self.beerDetailsVM.loadBeerDetails()
        }
    }
}

struct BeerDetails_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetails(beerId: 1)
    }
}
