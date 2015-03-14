//
//  BarsSettingsManger.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/14/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsSettingsManager.h"

@interface BarsSettingsManager()

@property (readwrite, nonatomic, strong) NSArray* settings;

@end

@implementation BarsSettingsManager

-(NSArray*)getSettings {
    if (!self.settings) {
        
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
        
        self.settings = [settingsItems copy];
    }
    return self.settings;
}

@end
