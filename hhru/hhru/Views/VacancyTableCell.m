//
//  VacancyTableCell.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "VacancyTableCell.h"
#import "UIImageView+WebCache.h"
#import "DateTools.h"

@implementation VacancyTableCell

- (void)setVacancy:(Vacancy *)vacancy {
    
    self.nameLabel.text = vacancy.name;
    self.companyLabel.text = vacancy.employer.name;
    self.salaryLabel.text = vacancy.formattedSalaryArea;
    self.dateLabel.text = [vacancy.publishedAt timeAgoSinceNow];
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:vacancy.employer.logo]];

}


@end
