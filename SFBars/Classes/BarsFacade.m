//
//  BarsManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/9/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsManager.h"

@interface BarsManager()

@property (readwrite, nonatomic, strong) NSArray* menuItems;
@property (readwrite, nonatomic, strong) NSArray* barDetailItems;
@property (readwrite, nonatomic, strong) NSArray* settingsItems;

@end

@implementation BarsManager

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

-(NSArray*)getSettingsItems {
    if (!self.settingsItems) {
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"SettingsItems" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: nil];
        data = nil;
        
        NSMutableArray* settingsItems = [[NSMutableArray alloc] init];
        SettingsItem* settingsItem;
        
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            settingsItem = [SettingsItem initFromDictionary: dictTemp];
            [settingsItems addObject:settingsItem];
        }

        self.settingsItems = [settingsItems copy];
    }
    return self.settingsItems;
}

@end
