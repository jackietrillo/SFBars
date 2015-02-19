//
//  Menu.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MenuItem.h"

@interface  MenuItem()

@end

@implementation MenuItem

static const NSString* SECTION = @"section";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    MenuItem* menuItem = [super initFromDictionary:dict forEntity:[[MenuItem alloc] init]];
    menuItem.section = [dict[SECTION] longValue];
    return menuItem;
}

@end
