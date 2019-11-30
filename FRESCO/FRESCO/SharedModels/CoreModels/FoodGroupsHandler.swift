//
//  FoodGroupsHandler.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 28/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct FoodGroupsHandler {
    func process(foodGroups: [FoodGroup]) -> EnergyRequirement{
        var equivalents = [Equivalent]()
        for group in foodGroups {
            let foods = group.foods
            var foodSumEquivalents: Double = 0
            for food in foods {
                let equivalent = process(food)
                foodSumEquivalents += equivalent
            }
            let equivalent = Equivalent(category: determineCategoryFrom(group), equivalent: foodSumEquivalents)
            equivalents.append(equivalent)
        }
        let equivalentsPerMacro = processEqs(equivalents)
        let energyRequirement = processEqsPerMacro(equivalentsPerMacro)
        return energyRequirement
    }
    private func processEqs(_ equivalents: [Equivalent]) -> [Equivalent]{
        var eqsPerMacro = [Equivalent]()
        for eq in equivalents {
            var equivalent = eq
            switch equivalent.category {
            case .verdura:
                equivalent.updateMacroNutrients(proteins: 2, lipids: 0, hcs: 4)
            case .fruta:
                equivalent.updateMacroNutrients(proteins: 0, lipids: 0, hcs: 15)
            case .cerealSinGrasa:
                equivalent.updateMacroNutrients(proteins: 2, lipids: 0, hcs: 15)
            case .cerealConGrasa:
                equivalent.updateMacroNutrients(proteins: 2, lipids: 5, hcs: 15)
            case .leguminosa:
                equivalent.updateMacroNutrients(proteins: 8, lipids: 1, hcs: 20)
            case .origenAnimal:
                equivalent.updateMacroNutrients(proteins: 7, lipids: 5, hcs: 0)
            case .lacteo:
                equivalent.updateMacroNutrients(proteins: 9, lipids: 8, hcs: 12)
            case .grasasSinProteina:
                equivalent.updateMacroNutrients(proteins: 0, lipids: 5, hcs: 0)
            case .grasasConProteina:
                equivalent.updateMacroNutrients(proteins: 3, lipids: 5, hcs: 3)
            case .azucar:
                equivalent.updateMacroNutrients(proteins: 0, lipids: 5, hcs: 10)
            default:
                break
            }
            eqsPerMacro.append(equivalent)
        }
        return eqsPerMacro
    }
    private func processEqsPerMacro(_ equivalents: [Equivalent]) -> EnergyRequirement {
        var nutrients = [MacroNutrient]()
        var protsGr = 0.0
        var lipidsGr = 0.0
        var hcsGr = 0.0
        var sumKcal: Float = 0.0
        for equivalent in equivalents {
            protsGr += equivalent.proteins ?? 0.0
            lipidsGr += equivalent.lipids ?? 0.0
            hcsGr += equivalent.hcs ?? 0.0
        }
        nutrients.append(MacroNutrient(kCal: Float(protsGr*4), grams: Float(protsGr), type: .protein))
        nutrients.append(MacroNutrient(kCal: Float(lipidsGr*9), grams: Float(lipidsGr), type: .lipid))
        nutrients.append(MacroNutrient(kCal: Float(hcsGr*4), grams: Float(hcsGr), type: .carboHydrate))
        for n in nutrients {
            sumKcal += n.kCal
        }
        return EnergyRequirement(nutrients: nutrients, sumKcal: sumKcal)
    }
    private func process(_ food: Food) -> Double {
        guard let weekly = food.weekly else {return 0.0}
        guard let times = food.times else {return 0.0}
        var z = 0.0
        switch weekly {
        case true:
            guard let quantity = food.quantity else {return 0.0}
            z = Double(times) * quantity
        default: //case false
            z = Double(times / 4)
        }
        let w = z / 7
        let eq = w / food.eq
        return eq
    }
    private func determineCategoryFrom(_ foodGroup: FoodGroup) -> FoodCategory {
        guard let first = foodGroup.foods.first else {return .noCategory}
        return first.category
    }
    func printEq(_ equivalents: [Equivalent]) {
        for eq in equivalents {
            print("\t\(eq.category):\(eq.equivalent)\n\t\tprots:\(eq.proteins ?? 0.0)|lips:\(eq.lipids ?? 0.0)|hcs:\(eq.hcs ?? 0.0)")
        }
    }
    func printER(_ er: EnergyRequirement) {
        guard let sumKcal = er.sumKcal else {return}
        print("\n\tTotal kcal: \(sumKcal)")
        guard let nutrients = er.nutrients else {return}
        for n in nutrients {
            print("\n\n\t\(n.type):\n\t\tgrams:\(n.grams)|kcal:\(n.kCal)")
        }
    }
}
