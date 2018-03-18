//
//  hhruTests.m
//  hhruTests
//
//  Created by Narikbi on 17.03.18.
//  Copyright © 2018 Narikbi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "VacanciesViewController.h"
#import "VacancyTableCell.h"
#import "NSObject+PWObject.h"
#import "VacancyApi.h"
#import "PaginatorResponse.h"
#import "Vacancy.h"

@interface hhruTests : XCTestCase
@property (nonatomic, strong) VacanciesViewController *vc;
@end

@implementation hhruTests

- (void)setUp {
    [super setUp];
    
    self.vc = [[VacanciesViewController alloc] init];
    [self.vc loadView];
    [self.vc viewDidLoad];
    
}

- (void)tearDown {
    [super tearDown];
}

- (void)testHasATableView {
    XCTAssertNotNil(self.vc.tableView);
}

- (void)testTableViewConfromsToTableViewDelegateProtocol {
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDelegate)]);
    XCTAssertTrue([self.vc respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]);
}

- (void)testTableViewHasDataSource {
    XCTAssertNotNil(self.vc.tableView.dataSource);
}

- (void)testTableViewConformsToTableViewDataSourceProtocol {
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDataSource)]);
    XCTAssertTrue([self.vc respondsToSelector:@selector(tableView:numberOfRowsInSection:)]);
    XCTAssertTrue([self.vc respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]);
}

- (void)testTableViewCellHasReuseIdentifier {
    
    __weak typeof(self) wself = self;
    [self performBlockOnSecond:^{
        VacancyTableCell *cell = [wself.vc.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSString *actualReuseIdentifer = cell.reuseIdentifier;
        NSString *expectedReuseIdentifier = @"VacancyTableCell";
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier);
    }];
    
}

- (void)testVacanciesApiCall {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"API request to get vacancies"];

    NSInteger perPage = 30;
    [VacancyApi vacanciesAtPage:@0 perPage:@(perPage) success:^(PaginatorResponse* response) {
        
        XCTAssertNotNil(response, @"Response is nil");
        XCTAssertTrue([response isKindOfClass:[PaginatorResponse class]], @"Response is not member of PaginatorResponse class");
        XCTAssertTrue(response.items.count > 0, @"Response's items are empty");

        for (int i = 0; i < response.items.count; i++) {
            XCTAssertTrue([[response.items objectAtIndex:i] isKindOfClass:[Vacancy class]], @"Failed to serialize vacancy object");
            Vacancy *vacancy = response.items[i];
            
            if (vacancy.salary != nil) {
                XCTAssertTrue([vacancy.salary isKindOfClass:[Salary class]], @"Failed to serialize salary object");
            }

            XCTAssertNotNil(vacancy.area , @"Vacancy area is nil");
            XCTAssertTrue([vacancy.area isKindOfClass:[Area class]], @"Failed to serialize area object");
            
            XCTAssertNotNil(vacancy.employer , @"Vacancy employer is nil");
            XCTAssertTrue([vacancy.employer isKindOfClass:[Employer class]], @"Failed to serialize employer object");
            
        }
        
        XCTAssertEqual(response.items.count, perPage, @"Items count doesn't equal to per_page");
        [expectation fulfill];

    } failure:^(NSInteger code, NSString *message) {
        XCTFail(@"Failed to get vacancies");
    }];
    
    [self waitForExpectationsWithTimeout:20 handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            XCTFail(@"Failed to get vacancies");
        }
    }];
}

- (void)testFormattedSalaryArea {
    
    // range
    Salary *salary1 = [[Salary alloc] initWithFrom:@500 to:@1000 gross:NO currency:@"USD"];
    Area *area1 = [[Area alloc] initWithAreaId:@1 name:@"Москва"];
    Employer *employer1 = [[Employer alloc] initWithEmpoyerId:@1 logo:nil name:@"Яндекс"];
    
    Vacancy *vacancy1 = [[Vacancy alloc] initWithName:@"PHP программист" publishedAt:[NSDate date] salary:salary1 area:area1 employer:employer1];
    NSString *expectedStr = @"500 - 1000 $・Москва";
    XCTAssertTrue([expectedStr isEqualToString: vacancy1.formattedSalaryArea]);

    // from
    Salary *salary2 = [[Salary alloc] initWithFrom:@100000 to:@0 gross:NO currency:@"KZT"];
    Area *area2 = [[Area alloc] initWithAreaId:@1 name:@"Алматы"];
    Employer *employer2 = [[Employer alloc] initWithEmpoyerId:@1 logo:nil name:@"Яндекс такси"];
    
    expectedStr = @"от 100000 ₸・Алматы";
    Vacancy *vacancy2 = [[Vacancy alloc] initWithName:@"Водитель" publishedAt:[NSDate date] salary:salary2 area:area2 employer:employer2];
    XCTAssertTrue([expectedStr isEqualToString: vacancy2.formattedSalaryArea]);

    // until
    Salary *salary3 = [[Salary alloc] initWithFrom:0 to:@1000 gross:NO currency:@"EUR"];
    Area *area3 = [[Area alloc] initWithAreaId:@1 name:@"Amsterdam"];
    Employer *employer3 = [[Employer alloc] initWithEmpoyerId:@1 logo:nil name:@"Yandex"];
    
    expectedStr = @"до 1000 €・Amsterdam";
    Vacancy *vacancy3 = [[Vacancy alloc] initWithName:@"Driver" publishedAt:[NSDate date] salary:salary3 area:area3 employer:employer3];
    XCTAssertTrue([expectedStr isEqualToString: vacancy3.formattedSalaryArea]);

    // empty
    expectedStr = @"Amsterdam";
    Vacancy *vacancy4 = [[Vacancy alloc] initWithName:@"ML engineer" publishedAt:[NSDate date] salary:nil area:area3 employer:employer3];
    XCTAssertTrue([expectedStr isEqualToString: vacancy4.formattedSalaryArea]);
    
}


@end

















