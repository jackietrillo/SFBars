//
//  BarDetailActionViewControllerFactory_Tests.m
//  SFBarsTests
//
//  Created by JACKIE TRILLO on 1/11/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import <XCTest/XCTest.h>
#import "BarsFacade.h"

@interface BarsFacade_Tests : XCTestCase

@property (readwrite, nonatomic, strong) BarsFacade* barsFacade;
@end

@implementation BarsFacade_Tests

- (void)setUp {
    [super setUp];
  
    self.barsFacade = [[BarsFacade alloc] init];
    
}

- (void)tearDown {
    self.barsFacade = nil;
    [super tearDown];
}

- (void)testSaveFavorite_WhenBarIdIsLessThanZero_shouldThrow {
   
    XCTAssertThrows([self.barsFacade saveFavorite: -999], @"Exception thrown");
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
