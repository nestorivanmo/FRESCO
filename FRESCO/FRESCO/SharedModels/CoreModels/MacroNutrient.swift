//
//  MacroNutrient.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct MacroNutrient: Codable {
    var kCal: Float
    var grams: Float
    var type: MacroNutrientEnum
}

enum MacroNutrientEnum: String, Codable {
    case protein, lipid, carboHydrate
}
