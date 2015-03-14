//
//  BarDetailItemsManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/14/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailItemsManager.h"

@interface BarDetailItemsManager()

@property (readwrite, nonatomic, strong) NSArray* barDetailItems;

@end

@implementation BarDetailItemsManager

-(NSArray*)getBarDetailItems {
    if (!self.barDetailItems) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"BarDetailItems" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        data = nil;
        
        NSMutableArray* barDetailItems = [[NSMutableArray alloc] init];
        BarDetailItem* barDetailItem;
        
        if (arrayData.count > 0) {
            for (int i = 0; i < arrayData.count; i++) {
                NSDictionary* dictTemp = arrayData[i];
                barDetailItem = [BarDetailItem initFromDictionary: dictTemp];
                [barDetailItems addObject:barDetailItem];
            }
        }
        
        self.barDetailItems = [barDetailItems copy];
    }
    return self.barDetailItems;
}
@end
