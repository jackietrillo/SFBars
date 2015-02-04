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

-(id)init
{
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    MenuItem* menuItem = [[MenuItem alloc] init];
    
    return [super initFromDictionary:dict forEntity:menuItem];
}

@end
