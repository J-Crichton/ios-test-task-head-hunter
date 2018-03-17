


#import "ModelObject.h"

@interface PaginatorResponse : ModelObject

@property (nonatomic, strong) NSArray  *items;
@property (nonatomic, strong) NSNumber *totalItem;
@property (nonatomic, strong) NSNumber *totalPage;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, getter=isLoaded) BOOL loaded;

- (instancetype)initWithVacancyData:(id)datas;
- (BOOL)hasNextPage;

@end
