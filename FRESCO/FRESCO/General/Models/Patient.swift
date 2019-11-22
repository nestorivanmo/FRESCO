//
//  Patient.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct Patient: Codable {
    var name: String
    var birthday: Date
    var age: Int
    var sex: Sex
    var weight: Float
    var height: Float
    var imc: IMC? = nil
    var pa: PhysicalActivity? = nil
    var energyRequirement: EnergyRequirement? = nil
}

extension Patient {
    
    mutating func doSomeMath() {
        self.imc = MathManager.calculateIMC(from: self)
        self.energyRequirement = MathManager.calculateER(from: self)
    }
    
    mutating func updatePA(with pa: PhysicalActivity) {
        self.pa = pa
    }
    
}

enum Sex: String, Codable {
    case female, male
}

extension Patient {
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("patients").appendingPathExtension("plist")
    static func loadPatient() -> Patient? {
        guard let codedPatient = try? Data(contentsOf: ArchiveURL) else {return nil}
        let decoder = PropertyListDecoder()
        return try? decoder.decode(Patient.self, from: codedPatient)
    }
    static func save(_ patient: Patient) {
        let encoder = PropertyListEncoder()
        let encodedPatient = try? encoder.encode(patient)
        try? encodedPatient?.write(to: ArchiveURL, options: .noFileProtection)
    }
}
