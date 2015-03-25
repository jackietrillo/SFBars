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

static const NSString* CONTROLLER = @"controller";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    MenuItem* menuItem = [super initFromDictionary:dict forItem:[[MenuItem alloc] init]];
    menuItem.controller = dict[CONTROLLER];
    return menuItem;
}

@end
