//
//  hhruTests.swift
//  hhruTests
//
//  Created by Асылбек on 15.03.2018.
//  Copyright © 2018 Асылбек. All rights reserved.
//

import XCTest
@testable import hhru

class hhruTests: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        //let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        //vc = storyboard.instantiateViewController(withIdentifier: "Main") as! ViewController
        vc = ViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - ViewController
    
    func testLabelValuesShowedProperly() {
        let _ = vc.view
        let vacancies = [Vacancy(title: "iOS developer", companyName: "hh.ru", salary: nil, logoURL: nil, image: nil)]
        vc.vacancies = vacancies
        vc.tableView.reloadData()
        let cell = vc.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VacancyViewCell
        XCTAssert(cell.titleLabel.text == "iOS developer", "titleLabel doesn't show the right text")
        XCTAssert(cell.companyNameLabel.text == "hh.ru", "companyNameLabel doesn't show the right text")
        XCTAssert(cell.salaryLabel.text == "не указано", "salaryLabel doesn't show the right text")
    }
    
    // MARK: - RequestManager
    
    func testVacanciesCount() {
        let e = expectation(description: "getVacanciesCount")
        RequestManager.sharedInstance.getVacancies(page: 0, success: { vacancies in
            XCTAssert(vacancies.count > 0, "vacancies can't be empty")
            e.fulfill()
        }, failure: { error in
            XCTAssertNil(error)
            e.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testIfTitleOrCompanyNameIsEmpty() {
        let e = expectation(description: "getVacancy")
        RequestManager.sharedInstance.getVacancies(page: 0, success: { vacancies in
            let vacancy = vacancies.first!
            XCTAssertNotNil(vacancy.title, "vacancy.title can't be empty")
            XCTAssertNotNil(vacancy.companyName, "vacancy.companyName can't be empty")
            e.fulfill()
        }, failure: { error in
            XCTAssertNil(error)
            e.fulfill()
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetVacanciesPerformance() {
        // This is an example of a performance test case.
        self.measure {
            let e = expectation(description: "getVacancyPerformance")
            RequestManager.sharedInstance.getVacancies(page: 0, success: { _ in
                e.fulfill()
            }, failure: { error in
                e.fulfill()
            })
            waitForExpectations(timeout: 10.0, handler: nil)
        }
    }
    
    // MARK: - Salary
    
    func testSalaryWithoutToValue() {
        let salary = Salary.init(from: 3000, to: nil, currency: "USD")
        let salaryString = salary.getSalaryString()
        XCTAssert(salaryString == "от 3000 USD", "getSalaryString doesn't work properly")
    }
    
    func testSalaryWithoutFromValue() {
        let salary = Salary.init(from: nil, to: 6000, currency: "USD")
        let salaryString = salary.getSalaryString()
        XCTAssert(salaryString == "до 6000 USD", "getSalaryString doesn't work properly")
    }
    
    func testSalaryWithValues() {
        let salary = Salary.init(from: 3000, to: 6000, currency: "USD")
        let salaryString = salary.getSalaryString()
        XCTAssert(salaryString == "3000-6000 USD", "getSalaryString doesn't work properly")
    }
    
}
