//
//  Patient.swift
//  FRESCO
//
//  Created by Néstor I. Martínez Ostoa on 21/11/19.
//  Copyright © 2019 Néstor I. Martínez Ostoa. All rights reserved.
//

import Foundation

struct Patient {
    var name: String
    var birthday: Date
    var age: Int
    var sex: Sex
    var weight: Float
    var height: Float
    lazy var imc: Float? = nil
    lazy var physicalActivity: Float? = nil
    
    init(name: String, birthday: Date, age: Int, sex: Sex, weight: Float, height: Float) {
        self.name = name
        self.birthday = birthday
        self.age = age
        self.sex = sex
        self.weight = weight
        self.height = height
    }
}

enum Sex {
    case female, male
}
