//
//  FCADetailTableViewController.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 20/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class FoodsTableViewController: UITableViewController {
    
    private let identifier = "FoodCell"
    var foods = [Food]()
    var foodGroupIndex: Int?
    var isFoodSelectionHidden = true
    var indexOfCellToExpand = -1
    
    @IBOutlet weak var readyBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FoodsTableViewController {
    func updateFoodWith(_ cell: FoodTableViewCell) {
        guard let indexPath = self.getCurrentIndexPath() else {return}
        var food = self.foods.remove(at: indexPath.row)
        let times = Int(cell.timesTextField.text ?? "0")!
        let week = cell.weekMonthSegmentedControl.selectedSegmentIndex == 0 ? true:false
        let quantity = Double(cell.quantityTextField.text ?? "0")!
        food.updateFood(times, week, quantity)
        self.foods.insert(food, at: indexPath.row)
    }
}

extension FoodsTableViewController {
    @IBAction func timesTextFieldChanged(_ sender: Any) {
        guard let cell = self.getCurrentCell() else {return}
        if cell.timesTextField.text == "0" || cell.timesTextField.text == ""{
            cell.foodImageView.tintColor = .lightGray
        } else {
            cell.foodImageView.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
        }
        updateFoodWith(cell)
    }
    @IBAction func quantityTextFieldChanged(_ sender: Any) {
        guard let cell = self.getCurrentCell() else {return}
        updateFoodWith(cell)
    }
    @IBAction func weekMonthSegmentedControlChanged(_ sender: Any) {
        guard let cell = self.getCurrentCell() else {return}
        if cell.weekMonthSegmentedControl.selectedSegmentIndex == 0 {
            self.modifyQuantityLabel(week: true, from: cell)
        } else {
            self.modifyQuantityLabel(week: false, from: cell)
        }
        updateFoodWith(cell)
    }
    @IBAction func timesTextFieldBeginEditing(_ sender: Any) {
        guard let cell = self.getCurrentCell() else {return}
        cell.timesTextField.selectAll(nil)
    }
    @IBAction func quantityTextFieldBeginEditing(_ sender: Any) {
        guard let cell = self.getCurrentCell() else {return}
        cell.quantityTextField.selectAll(nil)
    }
}

extension FoodsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! FoodTableViewCell
        let food = foods[indexPath.row]
        cell.foodLabel.text = food.name
        cell.quantityLabel.text = "\(food.unit)"
        if cell.timesTextField.text == " " || cell.timesTextField.text == ""{
            cell.timesTextField.text = "0"
        }
        cell.selectionStyle = .none
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
        
        guard let cell = self.getCurrentCell() else {return}
        if cell.timesTextField.text == " " || cell.timesTextField.text == ""{
            cell.timesTextField.text = "0"
        }
        cell.timesTextField.resignFirstResponder()
        cell.quantityTextField.resignFirstResponder()
        updateFoodWith(cell)
    }
}

extension FoodsTableViewController {
    func getCurrentIndexPath() -> IndexPath? {
        guard let indexPath = tableView.indexPathForSelectedRow else {return nil}
        return indexPath
    }
    func getCurrentCell() -> FoodTableViewCell? {
        guard let indexPath = self.getCurrentIndexPath() else {return nil}
        let cell = tableView.cellForRow(at: indexPath) as! FoodTableViewCell
        return cell
    }
    func modifyQuantityLabel(week: Bool, from cell: FoodTableViewCell) {
        if week {
            cell.quantityTextField.isEnabled = true
            cell.quantityTextField.textColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
        } else {
            cell.quantityTextField.isEnabled = false
            cell.quantityTextField.textColor = .tertiaryLabel
        }
    }
}
