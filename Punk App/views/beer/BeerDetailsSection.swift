//
//  BeerDetailsSection.swift
//  Punk App
//
//  Created by Alejandro Miranda on 22/10/22.
//

import SwiftUI

struct BeerDetailsSection: View {
    let sectionTitle: String
    let sectionBody: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.sectionTitle)
                .font(.system(size: 32.5))
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(self.sectionBody)
                .font(.system(size: 18))
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct BeerDetailsSection_Previews: PreviewProvider {
    static var previews: some View {
        BeerDetailsSection(sectionTitle: "Test", sectionBody: "This is an example of body")
    }
}
