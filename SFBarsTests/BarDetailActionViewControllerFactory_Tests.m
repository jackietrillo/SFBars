//
//  BarDetailActionViewControllerFactory_Tests.m
//  SFBarsTests
//
//  Created by JACKIE TRILLO on 1/11/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "BarDetailActionViewControllerFactory.h"

@interface BarDetailActionViewControllerFactory_Tests : XCTestCase

@property (readwrite, nonatomic, strong) BarDetailActionViewControllerFactory* barDetailActionViewControllerFactory;
@end

@implementation BarDetailActionViewControllerFactory_Tests

- (void)setUp {
    [super setUp];
  
    self.barDetailActionViewControllerFactory = [[BarDetailActionViewControllerFactory alloc] init];
    
}

- (void)tearDown {
    self.barDetailActionViewControllerFactory = nil;
    [super tearDown];
}

- (void)testControllerForAction_WhenBarIsNull_throwsArgumentNullExecption {
   
    XCTAssertThrows([self.barDetailActionViewControllerFactory viewControllerForAction:BarDetailActionTypeWebsite withBar:nil], @"Exception thrown");
}

/*
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}
*/
@end
