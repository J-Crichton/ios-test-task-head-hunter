//
//  Vacancy.swift
//  hhru
//
//  Created by Асылбек on 14.03.2018.
//  Copyright © 2018 Асылбек. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

struct Vacancy {
    var title: String
    var companyName: String
    var salary: String?
    var logoURL: String?
    var image: UIImage?
    
    static func parseJSON(items: JSON) -> [Vacancy] {
        var vacancies = [Vacancy]()
        for i in 0...items.count - 1 {
            let title = items[i]["name"].string!
            let companyName = items[i]["employer"]["name"].string!
            let logoURL = items[i]["employer"]["logo_urls"]["240"].string
            var salaryString = "не указано"
            if let salaryCurrency = items[i]["salary"]["currency"].string {
                let salaryFrom = items[i]["salary"]["from"].int
                let salaryTo = items[i]["salary"]["to"].int
                let salary = Salary.init(from: salaryFrom, to: salaryTo, currency: salaryCurrency)
                salaryString = salary.getSalaryString()
            }
            vacancies.append(Vacancy(title: title, companyName: companyName, salary: salaryString, logoURL: logoURL, image: nil))
        }
        return vacancies
    }
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

