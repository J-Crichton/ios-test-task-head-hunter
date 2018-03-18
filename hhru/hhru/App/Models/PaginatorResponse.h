


#import "ModelObject.h"

@interface PaginatorResponse : ModelObject

@property (nonatomic, strong) NSArray  *items;
@property (nonatomic, strong) NSNumber *totalItem;
@property (nonatomic, strong) NSNumber *totalPage;
@property (nonatomic, strong) NSNumber *currentPage;
@property (nonatomic, assign) NSNumber *perPage;
@property (nonatomic, getter=isLoaded) BOOL loaded;

- (instancetype)initWithVacancyData:(id)datas;
- (BOOL)hasNextPage;

@end
