//
//  Menu.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetail.h"

@interface  BarDetail()

@end

@implementation BarDetail

static const NSString* SECTION = @"section";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    BarDetail* barDetail = [super initFromDictionary:dict forEntity:[[BarDetail alloc] init]];
    barDetail.section = [dict[SECTION] longValue];
    return barDetail;
}

@end