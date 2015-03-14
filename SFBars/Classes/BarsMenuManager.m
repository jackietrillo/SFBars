//
//  BarsMenuManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/14/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsMenuManager.h"

@interface BarsMenuManager()

@property (readwrite, nonatomic, strong) NSArray* menuItems;

@end

@implementation BarsMenuManager

-(NSArray*)getMenuItems {
    if (!self.menuItems) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: nil];
        data = nil;
        
        NSMutableArray* menuItems = [[NSMutableArray alloc] init];
        MenuItem* menuItem;
        
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            menuItem = [MenuItem initFromDictionary: dictTemp];
            [menuItems addObject:menuItem];
        }
        
        self.menuItems = [menuItems copy];
    }
    return self.menuItems;
}

@end
