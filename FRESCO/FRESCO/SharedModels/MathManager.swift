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
    
    static func calculateER(from patient: Patient) -> EnergyRequirement? {
        guard let physicalActivity = patient.pa else {return nil}
        guard let imc = patient.imc?.value else {return nil}
        var mass: Float = 0.0
        var bmr: Float = 0.0
        if imc >= Float(18.5) && imc <= Float(24.9) {
            mass = patient.weight
        } else {
            let height = patient.height / 100
            let teoricWeght = 22.5 * (height*height)
            mass = teoricWeght
        }
        
        switch patient.sex {
        case .female:
            switch patient.age {
            case 18..<31:
                bmr = (14.818 * mass) + 486.6
            case 31..<61:
                bmr = (8.126 * mass) + 845.6
            default:
                return nil
            }
        default:
            switch patient.age {
            case 18..<31:
                bmr = (15.057 * mass) + 692.2
            case 31..<61:
                bmr = (11.472 * mass) + 873.1
            default:
                return nil
            }
        }
        
        let result = bmr * physicalActivity.value
        let hcKcal = result * 0.5
        let hcGrams = roundf((hcKcal / 4)*10)/10
        let protKcal = result * 0.2
        let protGrams = roundf((protKcal / 4)*10)/10
        let lipKcal = result * 0.3
        let lipGrams = roundf((lipKcal / 9)*10)/10
        
        let carbohydrates = MacroNutrient(kCal: roundf(hcKcal*10)/10, grams: hcGrams, type: .carboHydrate)
        let proteins = MacroNutrient(kCal: roundf(protKcal*10)/10, grams: protGrams, type: .protein)
        let lipids = MacroNutrient(kCal: roundf(lipKcal*10)/10, grams: lipGrams, type: .lipid)
        
        let nutrients = [carbohydrates, proteins, lipids]
        return EnergyRequirement(nutrients: nutrients, sumKcal: roundf(result*10)/10)
    }
}
