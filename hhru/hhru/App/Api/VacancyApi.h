//
//  VacancyApi.h
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "APIClient.h"

@interface VacancyApi : APIClient

+ (void)vacanciesAtPage:(NSNumber *)page perPage:(NSNumber *)perPage success:(Success)success failure:(Failure)failure;


@end
