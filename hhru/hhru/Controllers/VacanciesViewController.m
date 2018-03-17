//
//  VacanciesViewController.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "VacanciesViewController.h"
#import "VacancyTableCell.h"
#import "VacancyApi.h"
#import "PaginatorResponse.h"
#import "SVProgressHUD.h"
#import "LoadingFooterView.h"

@interface VacanciesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation VacanciesViewController {
    NSMutableArray *vacancies;
    PaginatorResponse *paginator;
    NSInteger currentPage;
    UIRefreshControl *refreshControl;
}

#pragma mark -
#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    }
    return self;
}

- (void)initVars {
    vacancies = [NSMutableArray new];
    currentPage = 0;
}

#pragma mark -
#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVars];
    [self configUI];
    
    [self loadFirstPage];
}

- (void)dealloc {
}

#pragma mark -
#pragma mark - Load data

- (void)loadFirstPage {
    currentPage = 0;
    [self loadData];
}

- (void)loadData {
    
    self.tableView.tableFooterView = [LoadingFooterView footerView];
    
    paginator.loaded = NO;
    __weak typeof(self) wself = self;
    
    [VacancyApi vacanciesAtPage:@(currentPage) perPage:@(30) success:^(PaginatorResponse* response) {
        [SVProgressHUD dismiss];
        [refreshControl endRefreshing];
        self.tableView.tableFooterView = nil;

        paginator = response;
        paginator.loaded = YES;
        if (currentPage == 0) {
            [vacancies removeAllObjects];
        }
        
        [vacancies addObjectsFromArray:response.items];
        [wself.tableView reloadData];
        
    } failure:^(NSInteger code, NSString *message) {
        [SVProgressHUD dismiss];
        [refreshControl endRefreshing];
        self.tableView.tableFooterView = nil;
    }];
    
}

#pragma mark -
#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return vacancies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VacancyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VacancyTableCell"];
    [cell setVacancy:vacancies[indexPath.row]];
    
    return cell;
}

#pragma mark -
#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger sections = [tableView numberOfSections];
    NSInteger items = [tableView numberOfRowsInSection:indexPath.section];
    
    if ([indexPath section] == sections - 1 && indexPath.item == items - 1) {
        NSLog(@"Last Row");
        if (paginator.loaded && paginator.hasNextPage) {
            currentPage++;
            [self loadData];
        }
    }
}


#pragma mark -
#pragma mark - ConfigUI

- (void)configUI {
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VacancyTableCell" bundle:nil] forCellReuseIdentifier:@"VacancyTableCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadFirstPage) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
//    UIImage *image = [UIImage imageNamed:@"logo"];
//    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];

}


@end
