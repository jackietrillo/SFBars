//
//  StreetManager.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "ConnectionHelper.h"
#import "StreetManager.h"
#import "Street.h"
#import "Bar.h"

@interface StreetManager()
    @property (readwrite, nonatomic, strong) NSMutableArray* streets;
    @property (readwrite, nonatomic, strong) NSMutableArray* hotSpots;
@end

@implementation StreetManager

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/sfstreet";

-(id)init {
    self = [super init];
    
    if (self) {
        
        _streets = [[NSMutableArray alloc] init];

        //TODO: expose this method and check return value
        [self loadData];
    }
    return self;
}

-(BOOL)loadData {
   
    ConnectionHelper* conn = [[ConnectionHelper alloc] init];
    NSData* data = [conn sendSyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    
    if (data == nil) {
    
        return false;
    }
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
        return false;
    }
    
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            Street* street = [Street initFromDictionary:dictTemp];
            [self.streets addObject:street];
         }
    }
    
    return true;
}

@end
