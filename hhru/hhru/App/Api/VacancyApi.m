//
//  VacancyApi.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "VacancyApi.h"
#import "PaginatorResponse.h"

@implementation VacancyApi

+ (void)vacanciesAtPage:(NSInteger)page perPage:(NSInteger)perPage success:(Success)success failure:(Failure)failure {
    
    NSDictionary *params = @{@"page" : @(page), @"per_page": @(perPage)};
    [self GET:@"vacancies" parameters:params success:^(id response) {
        
        PaginatorResponse *paginator = [[PaginatorResponse alloc] initWithVacancyData:response];
        success(paginator);
        
    } failure:failure];
    
}



@end
