//
//  EnergyRequirement.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct EnergyRequirement: Codable {
    var nutrients: [MacroNutrient]?
    var sumKcal: Float?
}
