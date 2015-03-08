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

static const NSString* BARTYPEID = @"barTypeId";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
   
    BarType* barType = [super initFromDictionary:dict forEntity:[[BarType alloc] init]];
   
    barType.itemId = [dict[BARTYPEID] integerValue];
    
    return barType;
}

@end
