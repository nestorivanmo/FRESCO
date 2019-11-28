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
//    let foodGroups = FCA.foodGroups
    var foodGroups = FCA.fg
    var foods = FCA.foods
    let emojis = ["🍅", "🍊", "🥖", "🥔", "🥜", "🥑", "🥬", "🐟", "🥛", "🥤", "🍷"]
    @IBOutlet weak var resultsBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateResultsBarButtonItem()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateResultsBarButtonItem()
    }
}

extension FoodGroupsTableViewController {
    func updateResultsBarButtonItem() {
        print("\nUpdating results bar button item\n")
        var checked = [FoodGroup]()
        var unchecked = [FoodGroup]()
        for foodGroup in self.foodGroups {
            if foodGroup.checked {
                checked.append(foodGroup)
            } else {
                unchecked.append(foodGroup)
            }
        }
        print("\nChecked food groups")
        self.printFG(checked)
        print("\nUnchecked food groups")
        self.printFG(unchecked)
        self.resultsBarButtonItem.isEnabled = unchecked.count == 0 ? true : false
    }
    func printFG(_ foodGroups: [FoodGroup]) {
        for fg in foodGroups {
            print("\t\(fg.name)")
        }
    }
}

extension FoodGroupsTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFoods" {
            guard let newIndexPath = tableView.indexPathForSelectedRow else {return}
            let destinationVC = segue.destination as! FoodsTableViewController
//            let foodGroup = foodGroups[newIndexPath.section][newIndexPath.row]
            let foodGroup = foodGroups[newIndexPath.section].name
            destinationVC.navigationItem.title = foodGroup
//            destinationVC.foods = foods[newIndexPath.row]
            destinationVC.foods = foodGroups[newIndexPath.row].foods
            destinationVC.foodGroupIndex = newIndexPath.row
        } else if segue.identifier == "ShowResults" {
            
        }
    }
    @IBAction func unwindToFoodGroups(segue: UIStoryboardSegue) {
        if segue.identifier == "ReturnToFoodGroups" {
            let sourceVC = segue.source as! FoodsTableViewController
            guard let foodGroupIndex = sourceVC.foodGroupIndex else {return}
//            self.foods.remove(at: foodGroupIndex)
//            self.foods.insert(sourceVC.foods, at: foodGroupIndex)
            self.foodGroups[foodGroupIndex].foods = sourceVC.foods
            self.foodGroups[foodGroupIndex].checked = sourceVC.shouldCheckFoodGroup
            self.updateResultsBarButtonItem()
        }
    }
}

extension FoodGroupsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.foodGroups[section].count
        if section == 0 {
            return self.foodGroups.count
        }
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodGroupCell", for: indexPath) as! FoodGroupTableViewCell
//        let category = foodGroups[indexPath.section][indexPath.row]
        let foodGroup = foodGroups[indexPath.row]
        let category = foodGroup.name
        let emoji = emojis[indexPath.row]
        cell.foodGroupLabel.text = category
        cell.foodGroupEmoji.text = indexPath.section == 0 ? emoji : ""
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(44)
    }
}
