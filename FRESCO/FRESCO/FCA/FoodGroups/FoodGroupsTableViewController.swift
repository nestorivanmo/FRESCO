//
//  FCATableViewController.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 20/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//
import UIKit

class FoodGroupsTableViewController: UITableViewController {

    let sections = FCA.sections
    let foodGroups = FCA.foodGroups
    var foods = FCA.foods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension FoodGroupsTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowFoods" else {return}
        guard let newIndexPath = tableView.indexPathForSelectedRow else {return}
        let destinationVC = segue.destination as! FoodsTableViewController
        let foodGroup = foodGroups[newIndexPath.section][newIndexPath.row]
        destinationVC.navigationItem.title = foodGroup
        destinationVC.foods = foods[newIndexPath.row]
        destinationVC.foodGroupIndex = newIndexPath.row
    }
    @IBAction func unwindToFoodGroups(segue: UIStoryboardSegue) {
        //segue from Listo bar buttom item: "ReturnToFoodGroups"
        if segue.identifier == "ReturnToFoodGroups" {
            let sourceVC = segue.source as! FoodsTableViewController
            guard let foodGroupIndex = sourceVC.foodGroupIndex else {return}
            self.foods.remove(at: foodGroupIndex)
            self.foods.insert(sourceVC.foods, at: foodGroupIndex)
            print(self.foods)
        }
    }
}

extension FoodGroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodGroups[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodGroupCell", for: indexPath)
        let category = foodGroups[indexPath.section][indexPath.row]
        cell.textLabel?.text = category
        cell.textLabel?.font = UIFont(name: "SF Pro Text", size: 16)
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitle: String = self.tableView(tableView, titleForHeaderInSection: section)!
        if sectionTitle == " " {
            return nil
        }
        let title = UILabel()
        title.text = sectionTitle
        title.textColor = .label
        title.backgroundColor = .clear
        title.font = UIFont(name: FixedSize.font, size: FixedSize.tableViewHeaderSize)
        title.font = UIFont.boldSystemFont(ofSize: FixedSize.tableViewHeaderSize)
        return title
    }
}
