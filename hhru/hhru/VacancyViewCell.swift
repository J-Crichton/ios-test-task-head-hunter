//
//  VacancyViewCell.swift
//  hhru
//
//  Created by Асылбек on 18.03.2018.
//  Copyright © 2018 Асылбек. All rights reserved.
//

import UIKit

class VacancyViewCell: UITableViewCell {
    var logoImageView: UIImageView!
    var titleLabel: UILabel!
    var companyNameLabel: UILabel!
    var salaryImageView: UIImageView!
    var salaryLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        logoImageView?.image = nil
    }
    
    func configureCell() {
        self.contentView.backgroundColor = .white
        
        let marginGuide = contentView.layoutMarginsGuide
        
        logoImageView = UIImageView()
        contentView.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 4).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        titleLabel = UILabel()
        contentView.addSubview(titleLabel)
        titleLabel.backgroundColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 4).isActive = true
        
        companyNameLabel = UILabel()
        contentView.addSubview(companyNameLabel)
        companyNameLabel.backgroundColor = .white
        companyNameLabel.font = UIFont.systemFont(ofSize: 14)
        companyNameLabel.textColor = .gray
        companyNameLabel.numberOfLines = 0
        companyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        companyNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        companyNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8).isActive = true
        companyNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        salaryImageView = UIImageView()
        contentView.addSubview(salaryImageView)
        salaryImageView.image = UIImage(named: "banknotes")
        salaryImageView.translatesAutoresizingMaskIntoConstraints = false
        salaryImageView.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8).isActive = true
        salaryImageView.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 6).isActive = true
        salaryImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        salaryImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        salaryImageView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -6).isActive = true
        
        salaryLabel = UILabel()
        contentView.addSubview(salaryLabel)
        salaryLabel.backgroundColor = .white
        salaryLabel.font = UIFont.systemFont(ofSize: 14)
        salaryLabel.textColor = .lightGray
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        salaryLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 6).isActive = true
        salaryLabel.leadingAnchor.constraint(equalTo: salaryImageView.trailingAnchor, constant: 8).isActive = true
        salaryLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
    }
}
