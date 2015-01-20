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

//@property (readwrite, nonatomic, strong) NSMutableArray* bars;

@end

@implementation BarManager

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bartype/";

-(id)init {
    self = [super init];
    
    if (self) {
        
        
    }
    return self;
}


-(NSMutableArray* )getBarsByBarType: (NSNumber*)barTypeId {
    
     NSString* barTypeUrl = [serviceUrl stringByAppendingString:[barTypeId stringValue]];
     
     ConnectionHelper* conn = [[ConnectionHelper alloc] init];
     NSData* data = [conn sendSyncRequest:barTypeUrl method:@"GET" accept:@"application/json"];
     
     if (data == nil) {
     
     return false;
     }
    
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
        return false;
    }
    
    NSMutableArray* bars = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            Bar* bar = [Bar initFromDictionary:dictTemp];
            [bars addObject:bar];
        }
    }
    
    return bars;
}
@end
