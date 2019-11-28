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

extension FoodGroup {
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("foodgroups").appendingPathExtension("plist")
    static func loadFoodGroups() -> [FoodGroup]? {
        guard let codedFGs = try? Data(contentsOf: ArchiveURL) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode([FoodGroup].self, from: codedFGs)
    }
    static func save(_ foodGroups: [FoodGroup]) {
        let encoder = PropertyListEncoder()
        let encodedFoodGroups = try? encoder.encode(foodGroups)
        try? encodedFoodGroups?.write(to: ArchiveURL, options: .noFileProtection)
    }
}
