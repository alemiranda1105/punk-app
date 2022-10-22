//
//  ValuesSectionItem.swift
//  Punk App
//
//  Created by Alejandro Miranda on 22/10/22.
//

import SwiftUI

struct ValuesSectionItem: View {
    let sectionTitle: String
    let sectionBody: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.sectionTitle)
                .font(.system(size: 22.5))
                .fontWeight(.semibold)
                .fixedSize(horizontal: false, vertical: true)
            
            Text(self.sectionBody)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct ValuesSectionItem_Previews: PreviewProvider {
    static var previews: some View {
        ValuesSectionItem(sectionTitle: "ABV", sectionBody: "6.87")
    }
}
