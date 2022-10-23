//
//  SearchFilters.swift
//  Punk App
//
//  Created by Alejandro Miranda on 23/10/22.
//

import Foundation

struct SearchFilter: CustomStringConvertible, Equatable {
    var abv_lt: Float
    var brewed_before: Date
    
    public var description: String {
        return "abv_lt=\(abv_lt.description)&brewed_before=\(brewed_before.formatted(.dateTime.month(.twoDigits).year()))"
    }
    
    init() {
        self.abv_lt = 100
        self.brewed_before = Date()
    }
    
    mutating func clearFilters() {
        abv_lt = 100
        brewed_before = Date()
    }
    
    static func ==(lhs: SearchFilter, rhs: SearchFilter) -> Bool {
        return lhs.abv_lt == rhs.abv_lt && lhs.brewed_before == rhs.brewed_before
    }
}
