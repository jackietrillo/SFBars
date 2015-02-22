//
//  Menu.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailItem.h"

@interface  BarDetailItem()

@end

@implementation BarDetailItem

static const NSString* SECTION = @"section";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    BarDetailItem* barDetailItem = [super initFromDictionary:dict forEntity:[[BarDetailItem alloc] init]];
    barDetailItem.section = [dict[SECTION] longValue];
    return barDetailItem;
}

@end
