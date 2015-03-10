//
//  SettingsItem.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/9/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "SettingsItem.h"

@interface SettingsItem()

@end

@implementation SettingsItem

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    SettingsItem* settingsItem = [super initFromDictionary:dict forItem:[[SettingsItem alloc] init]];
    
    return settingsItem;
}

@end
