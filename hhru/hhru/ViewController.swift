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

    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    var vacancies = [Vacancy]()
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        
        getVacancies(page: page, fromRefresh: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
                }
                self.vacancies = self.vacancies + vacancies
                if vacancies.count > 20 {
                    self.tableView.estimatedRowHeight = 0
                    self.tableView.estimatedSectionHeaderHeight = 0
                    self.tableView.estimatedSectionFooterHeight = 0
                }
                self.tableView.reloadData()
            });
        }, failure: { _ in
            let alert = UIAlertController(title: "Ошибка", message: "У Вас проблемы с сетью!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: { _ in
                if fromRefresh == true {
                    self.refreshControl.endRefreshing()
                }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

class VacancyViewCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView.image = nil
    }
    
}
