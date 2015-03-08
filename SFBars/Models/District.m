//
//  Street.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "District.h"

@interface District()

@end

@implementation District

static const NSString* DISTRICTID = @"districtId";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    District* district = [super initFromDictionary:dict forEntity:[[District alloc] init]];
    district.itemId = [dict[DISTRICTID] integerValue];
    return district;
}

@end
