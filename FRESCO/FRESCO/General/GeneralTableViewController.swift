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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
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
    
    @IBAction func unwindFromGeneralData(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "SavePatient" else {return}
        let sourceViewController = segue.source as! DatosGeneralesTableViewController
        guard let newPatient = sourceViewController.patient else {return}
        self.patient = newPatient
        self.heartImageView.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EnterGeneralData" {
            guard let patient = self.patient else {return}
            let destinationViewController = segue.destination as! DatosGeneralesTableViewController
            destinationViewController.updatePatientData(from: patient)
        }
    }

}
