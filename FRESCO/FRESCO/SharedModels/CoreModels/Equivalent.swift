//
//  Equivalent.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 28/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct Equivalent: Codable {
    var category: FoodCategory
    var equivalent: Double
    var hcs: Double?
    var proteins: Double?
    var lipids: Double?
    
    mutating func updateMacroNutrients(proteins: Double, lipids: Double, hcs: Double) {
        self.proteins = self.equivalent*proteins
        self.lipids = self.equivalent*lipids
        self.hcs = self.equivalent*hcs
    }
}
