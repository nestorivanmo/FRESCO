//
//  DatosGeneralesTableViewController.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class DatosGeneralesTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var birthdayDatePickerView: UIDatePicker!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isBirthdayDatePickerHidden = true
    let birhtdayDayFormatter: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    var toolbarIndex = 0
    
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        birthdayDatePickerView.date = Date().addingTimeInterval(24*60*60)
        updateBirthdayLabel(date: birthdayDatePickerView.date)
        guard let patient = self.patient else {return}
        self.updatePatientData(from: patient)
        updateUIState()
    }
    
    func updateUIState() {
        self.updateSaveButton()
        self.addToolbars()
    }
    
    func updatePatientData(from patient: Patient) {
        self.nameTextField.text = patient.name
        self.sexSegmentedControl.selectedSegmentIndex = (patient.sex == Sex.female) ? 0:1
        self.ageTextField.text = String(patient.age)
        self.weightTextField.text = String(Int(patient.weight))
        self.heightTextField.text = String(Int(patient.height))
        self.birthdayDatePickerView.date = patient.birthday
        self.birthdayLabel.text = birhtdayDayFormatter.string(from: patient.birthday)
        addToolbars()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "SavePatient" else {return}
        
        self.patient = Patient(name: nameTextField.text ?? "", birthday: birthdayDatePickerView.date, age: Int(ageTextField.text!)!, sex: getSex(), weight: Float(weightTextField.text!)!, height: Float(heightTextField.text!)!)
    }

}

extension DatosGeneralesTableViewController {
    @IBAction func nameTextFieldChanged(_ sender: Any) {
        updateUIState()
    }
    @IBAction func sexSegmentedControlChanged(_ sender: Any) {
        updateUIState()
    }
    
    func getSex() -> Sex{
        let index = sexSegmentedControl.selectedSegmentIndex
        if index == 0 {
            return .female
        }
        return .male
    }
    
    @IBAction func ageTextFieldChanged(_ sender: Any) {
        updateUIState()
    }
    
    @IBAction func weightTextFieldChanged(_ sender: Any) {
        updateUIState()
    }
    
    @IBAction func heightTextFieldChanged(_ sender: Any) {
        updateUIState()
    }
    @IBAction func nameTextFieldReturnedPressed(_ sender: Any) {
        nameTextField.resignFirstResponder()
    }
}

extension DatosGeneralesTableViewController {
    @IBAction func birthdayDatePickerChanged(_ sender: Any) {
        updateBirthdayLabel(date: birthdayDatePickerView.date)
        updateUIState()
    }
    func updateBirthdayLabel(date: Date) {
        birthdayLabel.text = self.birhtdayDayFormatter.string(from: date)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        switch indexPath {
        case [5,0]:
            return isBirthdayDatePickerHidden ? normalCellHeight:largeCellHeight
        default:
            return normalCellHeight
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case [5,0]:
            isBirthdayDatePickerHidden = !isBirthdayDatePickerHidden
            birthdayLabel.textColor = isBirthdayDatePickerHidden ? .label : #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }
}

extension DatosGeneralesTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitle: String = self.tableView(tableView, titleForHeaderInSection: section) ?? ""
        let title = UILabel()
        title.text = sectionTitle
        title.textColor = .label
        title.backgroundColor = .clear
        title.font = UIFont(name: FixedSize.font, size: FixedSize.tableViewHeaderSize)
        title.font = UIFont.boldSystemFont(ofSize: FixedSize.tableViewHeaderSize)
        return title
    }
}

extension DatosGeneralesTableViewController {
   
    func updateSaveButton() {
       let nameText = nameTextField.text ?? ""
       let ageText = ageTextField.text ?? ""
       let weightText = weightTextField.text ?? ""
       let heightText = heightTextField.text ?? ""
       saveButton.isEnabled = !nameText.isEmpty && !ageText.isEmpty && !weightText.isEmpty && !heightText.isEmpty
    }
    
    func addToolbars() {
        ViewFormatter.addToolbar(to: ageTextField)
        ViewFormatter.addToolbar(to: weightTextField)
        ViewFormatter.addToolbar(to: heightTextField)
    }
    
}
