//
//  Food.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 22/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct Food: Codable {
    var name: String
    var category: FoodCategory
    var unit: Unit
    var eq: Double
    var times: Int? = nil
    var quantity: Double? = nil
    var weekly: Bool? = nil
    
    mutating func updateFood(_ times: Int,_ weekly: Bool,_ quantity: Double) {
        self.times = times
        self.weekly = weekly
        self.quantity = quantity
    }
}

enum FoodCategory: String, Codable {
    case verdura
    case fruta
    case cerealSinGrasa
    case cerealConGrasa
    case leguminosa
    case origenAnimal
    case lacteo
    case grasasSinProteina
    case grasasConProteina
    case oleaginosa
    case azucar
    case bebidaAlcoholica
    case noCategory
}

enum Unit: String, Codable {
    case tazas
    case ml
    case cucharaditas
    case cucharadas
    case copas
    case piezas
    case gramos
    case pechugas
    case filetes
    case rebanadas
}
