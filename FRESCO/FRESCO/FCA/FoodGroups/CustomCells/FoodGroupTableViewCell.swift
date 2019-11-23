//
//  FoodGroupTableViewCell.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 23/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import UIKit

class FoodGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var foodGroupLabel: UILabel!
    @IBOutlet weak var foodGroupEmoji: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
