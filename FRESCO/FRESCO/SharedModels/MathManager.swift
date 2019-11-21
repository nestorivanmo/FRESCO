//
//  MathManager.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct MathManager {
    static func calculateIMC(from patient: Patient) -> IMC{
        let height = patient.height / 100.0
        let h2 = height * height
        let result = patient.weight / h2
        let value = roundf(result*100)/100
        return IMC(value: value)
    }
}
