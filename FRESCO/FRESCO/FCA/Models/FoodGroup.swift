//
//  FoodGroup.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 23/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct FoodGroup: Codable {
    var name: String
    var checked: Bool
    var foods: [Food]
}
