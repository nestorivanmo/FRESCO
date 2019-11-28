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
    var shouldCheckFoodGroup = false

    @IBOutlet weak var readyBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ReturnToFoodGroups" else {return}
        self.shouldCheckFoodGroup = true
    }
}

extension FoodsTableViewController {
    func updateFoodWith(_ cell: FoodTableViewCell) {
        guard let indexPath = self.getCurrentIndexPath() else {return}
        var food = self.foods.remove(at: indexPath.row)
        let times = Int(cell.timesTextField.text ?? "0") ?? 0
        let week = cell.weekMonthSegmentedControl.selectedSegmentIndex == 0 ? true:false
        let quantity = Double(cell.quantityTextField.text ?? "0") ?? 0.0
        food.updateFood(times, week, quantity)
        self.foods.insert(food, at: indexPath.row)
    }
    func updateCell(with cell: FoodTableViewCell, and food: Food) {
        if let times = food.times {
            if times > 0 {
                cell.foodImageView.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            }
            cell.timesTextField.text = String(times)
        }
        if let quantity = food.quantity {
            if quantity == 0.0 {
                cell.quantityTextField.text = "0"
            }else {
                cell.quantityTextField.text = String(quantity)
            }
        }
        if let weekly = food.weekly {
            cell.weekMonthSegmentedControl.selectedSegmentIndex = weekly ? 0:1
        }
    }
    func updateFoodImageView() {
        guard let cell = self.getCurrentCell() else {return}
        let timesTFText = cell.timesTextField.text
        let quantityTFText = cell.quantityTextField.text
        if cell.weekMonthSegmentedControl.selectedSegmentIndex == 0 { //weekly
            if timesTFText == "0" || quantityTFText == "0" || (timesTFText == "") {
                cell.foodImageView.tintColor = .lightGray
            } else {
                cell.foodImageView.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            }
        } else { //monthly
            if timesTFText == "0" || timesTFText == "" {
                cell.foodImageView.tintColor = .lightGray
            }else {
                cell.foodImageView.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
            }
        }
    }
}

extension FoodsTableViewController {
    @IBAction func timesTextFieldChanged(_ sender: Any) {
        updateFoodImageView()
        guard let cell = self.getCurrentCell() else {return}
        updateFoodWith(cell)
    }
    @IBAction func quantityTextFieldChanged(_ sender: Any) {
        updateFoodImageView()
        guard let cell = self.getCurrentCell() else {return}
        updateFoodWith(cell)
    }
    @IBAction func weekMonthSegmentedControlChanged(_ sender: Any) {
        updateFoodImageView()
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
        self.updateCell(with: cell, and: food)
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
        updateFoodImageView()
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

