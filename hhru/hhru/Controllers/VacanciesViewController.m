//
//  VacanciesViewController.m
//  hhru
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import "VacanciesViewController.h"

@interface VacanciesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation VacanciesViewController

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
}

#pragma mark -
#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVars];
    [self configUI];
}

- (void)dealloc {
}

#pragma mark -
#pragma mark - ConfigUI

- (void)configUI {
    
}


@end
