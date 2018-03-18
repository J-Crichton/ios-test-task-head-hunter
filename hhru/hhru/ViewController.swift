//
//  ViewController.swift
//  hhru
//
//  Created by Асылбек on 14.03.2018.
//  Copyright © 2018 Асылбек. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController {
    
    var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var vacancies = [Vacancy]()
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "hh.ru"
        
        configureTableView()
        
        getVacancies(page: page, fromRefresh: false)
    }
    
    func configureTableView() {
        tableView = UITableView(frame: self.view.frame, style: .plain)
        view.addSubview(tableView)
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = false
        tableView.register(VacancyViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.tableFooterView = UIView()
    }
    
    @objc private func refreshData(_ sender: Any) {
        getVacancies(page: 0, fromRefresh: true)
    }
    
    func getVacancies(page: Int, fromRefresh: Bool) {
        if vacancies.count == 0 {
            PKHUD.sharedHUD.contentView = PKHUDProgressView(title: "Одну секунду", subtitle: "")
            PKHUD.sharedHUD.show()
        }
        RequestManager.sharedInstance.getVacancies(page: page, success: { vacancies in
            DispatchQueue.main.async(execute: {
                if fromRefresh == true {
                    self.vacancies = []
                    self.refreshControl.endRefreshing()
                } else {
                    self.tableView.setContentOffset(self.tableView.contentOffset, animated: false)
                }
                self.vacancies = self.vacancies + vacancies
                self.tableView.reloadData()
            });
        }, failure: { _ in
            let alert = UIAlertController(title: "Ошибка", message: "У Вас проблемы с сетью!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Обновить", style: UIAlertActionStyle.default, handler: { _ in
                if fromRefresh == true {
                    self.refreshControl.endRefreshing()
                }
                self.getVacancies(page: 0, fromRefresh: false)
            }))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! VacancyViewCell
        let vacancy = vacancies[indexPath.row]
        cell.titleLabel.text = vacancy.title
        cell.companyNameLabel.text = vacancy.companyName
        if let salary = vacancy.salary {
            cell.salaryLabel.text = salary
        } else {
            cell.salaryLabel.text = "не указано"
        }
        cell.tag = indexPath.row
        if vacancy.image == nil {
            if let logoURL = vacancy.logoURL {
                RequestManager.sharedInstance.getCompanyLogo(url: logoURL, success: { image in
                    DispatchQueue.main.async(execute: {
                        if cell.tag == indexPath.row {
                            cell.logoImageView.image = image
                            self.vacancies[indexPath.row].image = image
                        }
                    })
                })
            } else {
                cell.logoImageView.image = UIImage(named: "default.png")
                self.vacancies[indexPath.row].image = UIImage(named: "default.png")
            }
        } else {
            cell.logoImageView.image = vacancy.image
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastVacancy = vacancies.count - 1
        if indexPath.row == lastVacancy {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 60)
            tableView.tableFooterView = spinner
            
            page = page + 1
            getVacancies(page: page, fromRefresh: false)
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
