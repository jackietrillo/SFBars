//
//  Street.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "District.h"

@interface District()

@property (readwrite, nonatomic) NSInteger districtId;
@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic, strong) NSMutableArray* bars;

@end

@implementation District

static const NSString* DISTRICTID = @"districtId";
static const NSString* NAME = @"name";
static const NSString* BARS = @"bars";

-(id)init
{
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    District* district = [[District alloc] init];
    district.districtId = [dict[DISTRICTID] longValue];
    district.name = dict[NAME];
    
    NSArray* arrayBarData = dict[BARS];
    
    district.bars = [[NSMutableArray alloc] init];
    
    //load bars
    for (int i = 0; i < arrayBarData.count ; i++)
    {
        NSDictionary* dictTemp = arrayBarData[i];
        Bar* bar = [Bar initFromDictionary:dictTemp ];
        [district.bars addObject:bar];
    }
    return district;
}

@end
