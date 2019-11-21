//
//  FCATableViewController.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 20/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class FCATableViewController: UITableViewController {

    let sections = FCA.sections
    let categories = FCA.categories
    let categoriesOptions = FCA.categoriesOptions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FCA_identifier", for: indexPath)
        cell.textLabel?.font = UIFont(name: "SF Pro Text", size: 16)
        cell.textLabel?.font = .boldSystemFont(ofSize: 16)
        cell.textLabel?.text = self.categories[indexPath.section][indexPath.row]
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
        title.font = UIFont(name: "SF Pro Text", size: 25)
        title.font = UIFont.boldSystemFont(ofSize: 25)
        
        return title
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showFCADetail" else {return}
        guard let newIndexPath = tableView.indexPathForSelectedRow else {return}
        let fcaDetailViewController = segue.destination as! FCADetailTableViewController
        fcaDetailViewController.navigationItem.title = categories[newIndexPath.section][newIndexPath.row]
        fcaDetailViewController.options = categoriesOptions[newIndexPath.row]
    }

}
