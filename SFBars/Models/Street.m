//
//  Street.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "Street.h"
#import "Bar.h"

@interface Street()

@property (readwrite, nonatomic, strong) NSNumber* streetId;
@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic, strong) NSString* descrip;
@property (readwrite, nonatomic, strong) NSString* imageUrl;
@property (readwrite, nonatomic) double latitude;
@property (readwrite, nonatomic) double longitude;
@end

@implementation Street

static const NSString* STREETID = @"sfStreetId";
static const NSString* NAME = @"name";
static const NSString* DESCRIPTION = @"descrip";
static const NSString* IMAGEURL = @"imageUrl";
static const NSString* LATITUDE = @"latitude";
static const NSString* LONGITUDE = @"longitude";
static const NSString* BARS = @"sfBars";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    Street* street = [[Street alloc] init];
    street.streetId = dict[STREETID];
    street.name = dict[NAME];
    street.descrip = dict[DESCRIPTION];
    street.imageUrl = dict[IMAGEURL];
    street.latitude = [dict[LATITUDE] doubleValue];
    street.longitude = [dict[LONGITUDE] doubleValue];
    
    NSArray* arrayBarData = dict[BARS];
    
    street.bars = [[NSMutableArray alloc] init];
    
    //load bars
    for (int i = 0; i < arrayBarData.count ; i++) {
        NSDictionary* dictTemp = arrayBarData[i];
        Bar* bar = [Bar initFromDictionary:dictTemp withStreet:street];
        [street.bars addObject:bar];
    }
    
    return street;
}

@end
