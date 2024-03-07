//
//  Country.swift
//  CountryAppCV
//
//  Created by Ziyadkhan on 24.09.23.
//

import Foundation

struct Country{
    var name: String
    var flag: String
    var cities: [City]
}

struct City {
    var name: String
    var image: String
    var info: String
}
