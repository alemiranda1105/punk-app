//
//  SearchBar.swift
//  Punk App
//
//  Created by Alejandro Miranda on 21/10/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var editing = false
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                TextField("Search for beers", text: self.$searchText)
                    .foregroundColor(Color(.black))
                if editing {
                    Spacer()
                    Button(action: {
                        self.editing = false
                        self.searchText = ""
                        // Dismiss the keyboard
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .transition(.opacity)
                    .animation(.default, value: 100)
                }
            }
            .padding(7)
            .background(Color(.systemGray6))
            .foregroundColor(Color(.lightGray))
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .onTapGesture {
                self.editing = true
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""))
    }
}
