//
//  PhysicalActivity.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct PhysicalActivity: Codable {
    var value: Float
    var category: PACategory
}

enum PACategory: String, Codable {
    case sedentary, active, vigorous, error
}

extension PhysicalActivity {
    
    static func getCategory(from value: Float) -> PACategory{
        switch value {
        case 1.4..<1.7:
            return .sedentary
        case 1.7..<2.0:
            return .active
        case 2.0...2.4:
            return .vigorous
        default:
            return .error
        }
    }
    
}
