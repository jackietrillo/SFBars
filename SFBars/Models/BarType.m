//
//  BarType.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarType.h"
#import "Bar.h"

@interface BarType()

@property (readwrite, nonatomic, strong) NSNumber* barTypeId;
@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic, strong) NSString* imageUrl;

//@property (readwrite, nonatomic, strong) NSMutableArray* bars;

@end

@implementation BarType

static const NSString* BARTYPEID = @"barTypeId";
static const NSString* NAME = @"name";
static const NSString* IMAGEURL = @"imageUrl";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    BarType* barType = [[BarType alloc] init];
    barType.barTypeId = dict[BARTYPEID];
    barType.name = dict[NAME];
    barType.imageUrl = dict[IMAGEURL];
    return barType;
}


@end