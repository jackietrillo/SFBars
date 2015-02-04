//
//  Street.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "District.h"

@interface District()

@property (readwrite, nonatomic, strong) NSMutableArray* bars;

@end

@implementation District

static const NSString* BARS = @"bars";

-(id)init
{
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    District* district = [super initFromDictionary:dict forEntity:[[District alloc] init]];
    
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
