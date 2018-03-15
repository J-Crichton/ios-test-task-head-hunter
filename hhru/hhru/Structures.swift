//
//  Vacancy.swift
//  hhru
//
//  Created by Асылбек on 14.03.2018.
//  Copyright © 2018 Асылбек. All rights reserved.
//

import Foundation
import UIKit

struct Vacancy {
    var title: String
    var companyName: String
    var salary: String?
    var logoURL: String?
    var image: UIImage?
}

struct Salary {
    var from: Int?
    var to: Int?
    var currency: String
    
    init(from: Int?, to: Int?, currency: String) {
        self.from = from
        self.to = to
        self.currency = currency
    }
    
    func getSalaryString() -> String {
        if from != nil && to != nil {
            return "\(from!)-\(to!) " + currency
        } else if from != nil && to == nil {
            return "от \(from!) " + currency
        } else if from == nil && to != nil {
            return "до \(to!) " + currency
        } else {
            return "не указано"
        }
    }
}
