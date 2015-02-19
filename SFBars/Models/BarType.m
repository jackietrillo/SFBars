//
//  BarType.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarType.h"

@interface BarType()

@property (readwrite, nonatomic, strong) NSMutableArray* bars;

@end

@implementation BarType

static const NSString* BARS = @"bars";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
   
    BarType* barType = [super initFromDictionary:dict forEntity:[[BarType alloc] init]];

    NSArray* bars = dict[BARS];
    
    if (bars) {
        barType.bars = [[NSMutableArray alloc] init];
        
        //load bars
        for (int i = 0; i < bars.count ; i++)
        {
            NSDictionary* dictTemp = bars[i];
            Bar* bar = [Bar initFromDictionary:dictTemp ];
            [barType.bars addObject:bar];
        }
    }
    return barType;
}


@end
