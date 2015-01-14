//
//  BarManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "ConnectionHelper.h"
#import "BarManager.h"
#import "Bar.h"

@interface BarManager()

@property (readwrite, nonatomic, strong) NSMutableArray* bars;

@end

@implementation BarManager

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars";

-(id)init {
    self = [super init];
    
    if (self) {
        
        _bars = [[NSMutableArray alloc] init];
        
        //TODO: expose this method and check return value
        [self loadData];
    }
    return self;
}

-(BOOL)loadData {
    
    /*
     ConnectionHelper* conn = [[ConnectionHelper alloc] init];
     NSData* data = [conn sendSyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
     
     if (data == nil) {
     
     return false;
     }
     */
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Bars" ofType:@"txt"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
        return false;
    }
    
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            Bar* bar = [Bar initFromDictionary:dictTemp];
            [self.bars addObject:bar];
        }
    }
    
    return true;
}

@end
