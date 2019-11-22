//
//  ViewFormatter.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation
import UIKit

struct ViewFormatter {
    
    public static func addToolbar(to target: UITextField) {
        
        let textFieldToolbar = UIToolbar()
        let doneBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: target, action: #selector(UITextField.resignFirstResponder))
        doneBarButtonItem.tintColor = #colorLiteral(red: 0.9361700416, green: 0.4429646432, blue: 0.3427112997, alpha: 1)
        textFieldToolbar.items = [
            doneBarButtonItem,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
        ]
        textFieldToolbar.sizeToFit()
        target.inputAccessoryView = textFieldToolbar
    }
    
    public static func resultFor(label: UILabel) {
        label.tintColor = .label
        label.font = .boldSystemFont(ofSize: 16)
    }
}
