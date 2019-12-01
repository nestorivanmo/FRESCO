//
//  ComparisonViewController.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 29/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation
import UIKit

class ComparisonViewController: UIViewController {
    
    @IBOutlet weak var distributionProteinLabel: UILabel!
    @IBOutlet weak var distributionHCLabel: UILabel!
    @IBOutlet weak var distributionLipidLabel: UILabel!
    
    @IBOutlet weak var adequateTotalLabel: UILabel!
    @IBOutlet weak var adequateProteinLabel: UILabel!
    @IBOutlet weak var adequateHCLabel: UILabel!
    @IBOutlet weak var adequateLipidLabel: UILabel!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    
    var idealEnergyRequirement: EnergyRequirement?
    var realEnergyRequirement: EnergyRequirement?
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateInformacion()
    }
    
    var informacionPaciente = ""
    
    func updateInformacion() {
        guard let patient = patient else {return}
        guard let idealER = idealEnergyRequirement else {return}
        guard let idealN = idealER.nutrients else {return}
        guard let realER = realEnergyRequirement else {return}
        guard let realN = realER.nutrients else {return}

        var hcIdeal: Float = 0
        var protIdeal: Float = 0
        var lipIdeal: Float = 0

        var hcReal: Float = 0
        var protReal: Float = 0
        var lipReal: Float = 0

        for n in idealN {
            switch n.type {
            case .carboHydrate:
                hcIdeal = n.kCal.rounded(toPlaces: 1)
            case .protein:
                protIdeal = n.kCal.rounded(toPlaces: 1)
            case .lipid:
                lipIdeal = n.kCal.rounded(toPlaces: 1)
            }
        }

        for n in realN {
            let result = n.kCal.rounded(toPlaces: 1)
            switch n.type {
            case .carboHydrate:
                hcReal = result
            case .protein:
                protReal = result
            case .lipid:
                lipReal = result
            }
        }

        informacionPaciente = """
        Nombre: \(patient.name)
        \nEdad: \(patient.age)
        \nSexo: \(patient.sex)
        \nPeso: \(patient.weight)
        \nAltura: \(patient.height)
        \nIMC: \(patient.imc!)
        \nRequerimiento Energético:
        \n\tkCal Totales: \(idealER.sumKcal!)
        \n\tkCal Carbohidratos: \(hcIdeal)
        \n\tkCal Proteínas: \(protIdeal)
        \n\tkCal Lípidos: \(lipIdeal)
        \nResultados FCA:
        \n\tkCal Totales: \(realER.sumKcal!)
        \n\tkCal Carbohidratos: \(hcReal)
        \n\tkCal Proteínas: \(protReal)
        \n\tkCal Lípidos: \(lipReal)
        """
    }
    
    @IBAction func shareBarButtonClicked(_ sender: Any) {
//        print(informacionPaciente)
        let activityController = UIActivityViewController(activityItems: [informacionPaciente], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as! UIButton
        present(activityController, animated: true, completion: nil)
    }
    
    
    func updateUI() {
        guard let idealSumKcal = idealEnergyRequirement?.sumKcal else {return}
        guard let idealNutrients = idealEnergyRequirement?.nutrients else {return}
        for n in idealNutrients {
            let result = (n.kCal*100)/idealSumKcal
            let r = result.rounded(toPlaces: 1)
            switch n.type {
            case .carboHydrate:
                print("HC:\(r)")
                distributionHCLabel.text = String(r)
            case .protein:
                print("Protein:\(r)")
                distributionProteinLabel.text = String(r)
            case .lipid:
                print("Lipid:\(r)")
                distributionLipidLabel.text = String(r)
            }
        }
        guard let realSumKcal = realEnergyRequirement?.sumKcal else {return}
        guard let realNutrients = realEnergyRequirement?.nutrients else {return}
        let totalKcal = ((realSumKcal*100)/idealSumKcal).rounded(toPlaces: 1)
        adequateTotalLabel.text = String(totalKcal)
        var i = 0
        for n in realNutrients {
            let idealN = idealNutrients[i]
            let result = ((n.kCal * 100)/idealN.kCal).rounded(toPlaces: 1)
            switch n.type {
            case .carboHydrate:
                print("HC-real:\(result)")
                adequateHCLabel.text = String(result)
            case .protein:
                print("Protein-real:\(result)")
                adequateProteinLabel.text = String(result)
            case .lipid:
                print("Lipid-real:\(result)")
                adequateLipidLabel.text = String(result)
            }
            i += 0
        }
    }
}

extension Float {
    func rounded(toPlaces places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
