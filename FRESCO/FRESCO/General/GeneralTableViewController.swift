//
//  GeneralTableViewController.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class GeneralTableViewController: UITableViewController {
    
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var imcLabel: UILabel!
    @IBOutlet weak var physAcTextField: UITextField!
    @IBOutlet weak var physAcLabel: UILabel!
    @IBOutlet weak var physAcFirstCircle: UIImageView!
    @IBOutlet weak var physAcSecondCircle: UIImageView!
    @IBOutlet weak var physAcThirdCircle: UIImageView!
    
    @IBOutlet weak var totalKCalIdealLabel: UILabel!
    @IBOutlet weak var hcKcalIdealLabel: UILabel!
    @IBOutlet weak var protKcalIdealLabel: UILabel!
    @IBOutlet weak var lipKcalIdealLabel: UILabel!
    @IBOutlet weak var hcGrIdealLabel: UILabel!
    @IBOutlet weak var protGrIdealLabel: UILabel!
    @IBOutlet weak var lipGrIdealLabel: UILabel!

    var patient: Patient?
    var imc: IMC?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUIState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateUIState()
    }
    
    @IBAction func physAcTextFieldChanged(_ sender: Any) {
        guard let _ = self.patient else {return}
        let value = Float(self.physAcTextField.text ?? "0") ?? 0.0
        let category = PhysicalActivity.getCategory(from: value)
        self.patient?.updatePA(with: PhysicalActivity(value: value, category: category))
        Patient.save(self.patient!)
        self.updateUIState()
    }

}

extension GeneralTableViewController {
    @IBAction func physAcTextFieldDidBeginEditing(_ sender: Any) {
        physAcTextField.selectAll(nil)
        physAcTextField.tintColor = .systemBlue
    }
}

extension GeneralTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitle: String = self.tableView(tableView, titleForHeaderInSection: section)!
        let title = UILabel()
        title.text = sectionTitle
        title.textColor = .label
        title.backgroundColor = .clear
        title.font = UIFont(name: FixedSize.font, size: FixedSize.tableViewHeaderSize)
        title.font = UIFont.boldSystemFont(ofSize: FixedSize.tableViewHeaderSize)
        return title
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension GeneralTableViewController {
    @IBAction func unwindFromGeneralData(_ segue: UIStoryboardSegue) {
        if segue.identifier == "SavePatient"{
            let sourceViewController = segue.source as! DatosGeneralesTableViewController
            guard let newPatient = sourceViewController.patient else {return}
            Patient.save(newPatient)
            self.updateUIState()
        }
    }
    @IBAction func unwindFromResults(_ segue: UIStoryboardSegue) {
        if segue.identifier == "ShowResults" {
            let indexPath = IndexPath(row: 0, section: 4)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            let cell = tableView.cellForRow(at: indexPath)
            UIView.animate(withDuration: 1) {
                cell?.backgroundColor = .lightGray
            }
            UIView.animate(withDuration: 0.5) {
                cell?.backgroundColor = UIColor(named: "CustomTableViewCellColor")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnterGeneralData" {
            guard let patient = self.patient else {return}
            let destinationViewController = segue.destination as! DatosGeneralesTableViewController
            destinationViewController.patient = patient
        }
    }
}

extension GeneralTableViewController {
    func updateUIState() {
        ViewFormatter.addToolbar(to: physAcTextField)
        self.patient = Patient.loadPatient()
        if let _ = self.patient {
            self.heartImageView.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            self.patient?.doSomeMath()
            self.imcLabel.text = String(self.patient?.imc?.value ?? 0)
            self.imcLabel.textColor = .label
            self.imcLabel.font = .boldSystemFont(ofSize: 20)
            
            if let physicalActivity = self.patient?.pa {
                self.updatePhysicalActivity(from: physicalActivity.category, and: physicalActivity.value)
                //calculate Energy Requirements
                self.patient?.doSomeMath()
                self.updateEnergyRequirement()
            }else {
                //delete ER
                self.updatePhysicalActivity(from: .error, and: 0)
            }
        } else {
            self.heartImageView.tintColor = .lightGray
        }
    }
    func updatePhysicalActivity(from category: PACategory, and value: Float) {
        self.physAcTextField.text = String(value)
        self.physAcTextField.tintColor = .label
        self.physAcTextField.font = .boldSystemFont(ofSize: 18)
        
        self.physAcLabel.tintColor = .label
        self.physAcLabel.font = .boldSystemFont(ofSize: 18)
        
        switch category {
        case .sedentary:
            self.physAcLabel.text = "Sedentario"
            self.updatePACircles(with: 1)
        case .active:
            self.physAcLabel.text = "Activo"
            self.updatePACircles(with: 2)
        case .vigorous:
            self.physAcLabel.text = "Vigoroso"
            self.updatePACircles(with: 3)
        default:
            //show alert error
            self.physAcLabel.text = "--"
            self.physAcTextField.text = "--"
            self.physAcLabel.tintColor = .lightGray
            self.physAcLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            self.physAcTextField.tintColor = .lightGray
            self.physAcTextField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        }
    }
    func updatePACircles(with number: Int) {
        switch number {
        case 1:
            physAcFirstCircle.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            physAcSecondCircle.tintColor = .lightGray
            physAcThirdCircle.tintColor = .lightGray
        case 2:
            physAcFirstCircle.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            physAcSecondCircle.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            physAcThirdCircle.tintColor = .lightGray
        case 3:
            physAcFirstCircle.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            physAcSecondCircle.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            physAcThirdCircle.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
        default:
            physAcFirstCircle.tintColor = .lightGray
            physAcSecondCircle.tintColor = .lightGray
            physAcThirdCircle.tintColor = .lightGray
        }
    }
    func updateEnergyRequirement() {
        guard let patient = self.patient else {return}
        guard let er = patient.energyRequirement else {return}
        guard let nutrients = er.nutrients else {return}
        
        guard let sumKcal = er.sumKcal else {return}
        self.totalKCalIdealLabel.text = String(sumKcal)
        self.totalKCalIdealLabel.tintColor = .label
        self.totalKCalIdealLabel.font = .boldSystemFont(ofSize: 18)
        
        for nutrient in nutrients {
            
            let kcal = nutrient.kCal
            let grams = nutrient.grams
            
            switch nutrient.type {
            case .carboHydrate:
                self.hcKcalIdealLabel.text = String(kcal)
                self.hcGrIdealLabel.text = String(grams)
                ViewFormatter.resultFor(label: hcKcalIdealLabel)
                ViewFormatter.resultFor(label: hcGrIdealLabel)
            case .protein:
                self.protKcalIdealLabel.text = String(kcal)
                self.protGrIdealLabel.text = String(grams)
                ViewFormatter.resultFor(label: protKcalIdealLabel)
                ViewFormatter.resultFor(label: protGrIdealLabel)
            default:
                self.lipKcalIdealLabel.text = String(kcal)
                self.lipGrIdealLabel.text = String(grams)
                ViewFormatter.resultFor(label: lipKcalIdealLabel)
                ViewFormatter.resultFor(label: lipGrIdealLabel)
            }
        }
    }
}
