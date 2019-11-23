//
//  FCADetailTableViewController.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 20/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    private let identifier = "FoodCell"
    var options = [Food]()
    var isFoodSelectionHidden = true
    var indexOfCellToExpand = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FoodTableViewCell
        let food = options[indexPath.row]
        cell.foodLabel.text = food.name
        cell.quantityLabel.text = String(Substring(Unit(rawValue: "\(food.unit)")!.rawValue))
        ViewFormatter.addToolbar(to: cell.quantityTextField)
        ViewFormatter.addToolbar(to: cell.timesTextField)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight: CGFloat = 44
        let expandedCellHeight: CGFloat = 150
        if indexPath.row == self.indexOfCellToExpand {
            return expandedCellHeight
        }
        return normalCellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isFoodSelectionHidden = !isFoodSelectionHidden
        indexOfCellToExpand = isFoodSelectionHidden ? -1:indexPath.row
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func timesTextFieldChanged(_ sender: Any) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let cell = tableView.cellForRow(at: indexPath) as! FoodTableViewCell
        if cell.timesTextField.text == "0" || cell.timesTextField.text == ""{
            cell.timesTextField.text = "0"
            cell.foodImageView.tintColor = .lightGray
        } else {
            cell.foodImageView.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
        }
    }
    
}

