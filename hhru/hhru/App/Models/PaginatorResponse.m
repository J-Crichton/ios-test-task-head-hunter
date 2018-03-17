

#import "PaginatorResponse.h"
#import "Vacancy.h"

@implementation PaginatorResponse

- (instancetype)initWithVacancyData:(id)datas {
    self = [super init];
    if (self) {
        [self initVars:datas];
        if ([self isValid:[datas objectForKey:@"items"]]) {
            NSMutableArray *res = [NSMutableArray array];
            NSArray *items = [datas objectForKey:@"items"];
            if (items && items.count) {
                for (id json in items) {
                    Vacancy *item = [Vacancy instanceFromDictionary:json];
                    [res addObject:item];
                }
                self.items = [[NSArray alloc] initWithArray:res];
            }
        }
    }
    return self;
}

- (void)initVars:(id)datas {
    self.totalPage  = [self numberValueFrom:datas forKey:@"pages"];
    self.totalItem   = [self numberValueFrom:datas forKey:@"found"];

    self.items = [NSArray new];
}

- (BOOL)hasNextPage {
    NSLog(@"currentPage: %ld, totalPage: %@", self.currentPage, self.totalPage);
    return self.totalPage.integerValue > 0 && self.currentPage < self.totalPage.integerValue;
}






@end
