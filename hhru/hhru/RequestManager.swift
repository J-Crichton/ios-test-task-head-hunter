//
//  RequestManager.swift
//  hhru
//
//  Created by Асылбек on 14.03.2018.
//  Copyright © 2018 Асылбек. All rights reserved.
//


import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
import PKHUD


class RequestManager {
    
    static let sharedInstance : RequestManager = {
        let url = "https://api.hh.ru/"
        let instance = RequestManager(baseURL: url)
        return instance
    }()
    
    let baseURL : String
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func getVacancies(page:Int, success: @escaping (_ result: [Vacancy]) -> Void, failure: @escaping (_ result: Error) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(baseURL + "vacancies?page=\(page)", method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let items = JSON(value)["items"]
                let count = items.count
                if count > 0 {
                    let vacancies = Vacancy.parseJSON(items: items)
                    PKHUD.sharedHUD.hide()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    success(vacancies)
                    return
                }
                PKHUD.sharedHUD.hide()
            case .failure(let error):
                PKHUD.sharedHUD.hide()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                failure(error)
                return
            }
        }
    }
    
    func getCompanyLogo(url: String, success: @escaping (_ result: UIImage) -> Void) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                success(image)
                return
            }
        }
    }
}
