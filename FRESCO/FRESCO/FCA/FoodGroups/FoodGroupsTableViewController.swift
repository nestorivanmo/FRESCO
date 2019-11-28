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
    var foodGroups = FoodGroup.loadFoodGroups() ?? FCA.fg
    let emojis = ["🍅", "🍊", "🥖", "🥔", "🥜", "🥑", "🥬", "🐟", "🥛", "🥤", "🍷"]
    @IBOutlet weak var resultsBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIState()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUIState()
    }
    func updateUIState() {
        self.foodGroups = FoodGroup.loadFoodGroups() ?? FCA.fg
        updateResultsBarButtonItem()
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
    func resetFCA() {
        foodGroups = FCA.fg
        resultsBarButtonItem.isEnabled = false
        tableView.reloadData()
        FoodGroup.save(foodGroups)
    }
}

extension FoodGroupsTableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFoods" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let destinationVC = segue.destination as! FoodsTableViewController
            if indexPath.section == 0 {
                //let foodGroup = foodGroups[newIndexPath.section][newIndexPath.row]
                let foodGroup = foodGroups[indexPath.section].name
                destinationVC.navigationItem.title = foodGroup
                //destinationVC.foods = foods[newIndexPath.row]
                destinationVC.foods = foodGroups[indexPath.row].foods
                destinationVC.foodGroupIndex = indexPath.row
            }
        } else if segue.identifier == "ShowResults" {
            
        } else if segue.identifier == "ShowExtraInformation" {
            //do sth
        }
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let indexPath = tableView.indexPathForSelectedRow else {return true}
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.performSegue(withIdentifier: "ShowExtraInformation", sender: nil)
            }
            return false
        }
        return true
    }
    @IBAction func unwindToFoodGroups(segue: UIStoryboardSegue) {
        if segue.identifier == "ReturnToFoodGroups" {
            let sourceVC = segue.source as! FoodsTableViewController
            guard let foodGroupIndex = sourceVC.foodGroupIndex else {return}
//            self.foods.remove(at: foodGroupIndex)
//            self.foods.insert(sourceVC.foods, at: foodGroupIndex)
            self.foodGroups[foodGroupIndex].foods = sourceVC.foods
            self.foodGroups[foodGroupIndex].checked = sourceVC.shouldCheckFoodGroup
            if foodGroups[foodGroupIndex].checked {
                let indexPath = IndexPath(row: foodGroupIndex, section: 0)
                let cell = tableView.cellForRow(at: indexPath) as! FoodGroupTableViewCell
                cell.foodGroupEmoji.text = self.emojis[foodGroupIndex]
            }
            FoodGroup.save(foodGroups)
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
            return foodGroups.count
        } else if section == 1 {
            return 2
        }
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodGroupCell", for: indexPath) as! FoodGroupTableViewCell
        if indexPath.section == 0 {
            //        let category = foodGroups[indexPath.section][indexPath.row]
            let foodGroup = foodGroups[indexPath.row]
            let category = foodGroup.name
            let emoji = emojis[indexPath.row]
            cell.foodGroupLabel.text = category
            cell.foodGroupEmoji.text = foodGroup.checked ? emoji : ""
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.foodGroupLabel.text = "Acerca de FCA"
            } else if indexPath.row == 1 {
                cell.foodGroupLabel.text = "Reinicia FCA"
                cell.foodGroupLabel.textColor = .systemRed
            }
            cell.foodGroupEmoji.text = ""
        }
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                let alertController = UIAlertController(title: "Reiniciar FCA", message: "¿Estás segur@ que quieres reiniciar el FCA?", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                let resetAction = UIAlertAction(title: "Sí", style: .destructive) { (action) in
                    self.resetFCA()
                }
                alertController.addAction(cancelAction)
                alertController.addAction(resetAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
