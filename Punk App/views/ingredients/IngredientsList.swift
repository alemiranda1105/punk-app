//
//  IngredientsList.swift
//  Punk App
//
//  Created by Alejandro Miranda on 22/10/22.
//

import SwiftUI

struct IngredientsList: View {
    @Binding var ingredients: Ingredients
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if ingredients.malt != nil {
                Text("Malt")
                    .font(.system(size: 22.5))
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)
                ForEach(ingredients.malt!, id:\.name) { malt in
                    HStack {
                        Text("\(malt.name ?? ""):")
                            .fontWeight(.medium)
                        Text("\(malt.amount?.description ?? "")")
                    }
                }
            }
            if ingredients.hops != nil {
                Text("Hops")
                    .font(.system(size: 22.5))
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)
                ForEach(ingredients.hops!, id:\.name) { hops in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(hops.name ?? ""):")
                                .fontWeight(.medium)
                            Text("\(hops.amount?.description ?? "")")
                        }
                        Text("Adds \(hops.attribute ?? "")")
                            .fontWeight(.light)
                        Text("Use in \(hops.add ?? "")")
                            .fontWeight(.light)
                    }
                }
            }
            if ingredients.yeast != nil {
                Text("Yeast")
                    .font(.system(size: 22.5))
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: false, vertical: true)
                Text("\(ingredients.yeast ?? "")")
                
            }
        }
    }
}

struct IngredientsList_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsList(ingredients: .constant(mockBeer.ingredients!))
    }
}
