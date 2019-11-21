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
    var isBirthdayDatePickerHidden = true
    
    let birhtdayDayFormatter: DateFormatter = {
            let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        birthdayDatePickerView.date = Date().addingTimeInterval(24*60*60)
        updateBirthdayLabel(date: birthdayDatePickerView.date)
    }
    
}

extension DatosGeneralesTableViewController {
    @IBAction func nameTextFieldChanged(_ sender: Any) {
        
    }
    @IBAction func nameTextFieldReturnedPressed(_ sender: Any) {
        nameTextField.resignFirstResponder()
    }
}

extension DatosGeneralesTableViewController {
    @IBAction func birthdayDatePickerChanged(_ sender: Any) {
        updateBirthdayLabel(date: birthdayDatePickerView.date)
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
