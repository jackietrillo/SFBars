//
//  Street.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "SFStreet.h"
#import "SFBar.h"

@interface SFStreet()

@property (readwrite, nonatomic, strong) NSNumber* streetId;
@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic, strong) NSString* descrip;
@property (readwrite, nonatomic, strong) NSString* imageUrl;
@property (readwrite, nonatomic) double latitude;
@property (readwrite, nonatomic) double longitude;
@end

@implementation SFStreet

static const NSString* SFSTREETID = @"sfStreetId";
static const NSString* NAME = @"name";
static const NSString* DESCRIPTION = @"descrip";
static const NSString* IMAGEURL = @"imageUrl";
static const NSString* LATITUDE = @"latitude";
static const NSString* LONGITUDE = @"longitude";
static const NSString* SFBARS = @"sfBars";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    SFStreet* street = [[SFStreet alloc] init];
    street.streetId = dict[SFSTREETID];
    street.name = dict[NAME];
    street.descrip = dict[DESCRIPTION];
    street.imageUrl = dict[IMAGEURL];
    street.latitude = [dict[LATITUDE] doubleValue];
    street.longitude = [dict[LONGITUDE] doubleValue];
    
    NSArray* arrayBarData = dict[SFBARS];
    
    street.bars = [[NSMutableArray alloc] init];
    
    //load bars
    for (int i = 0; i < arrayBarData.count ; i++) {
        NSDictionary* dictTemp = arrayBarData[i];
        SFBar* bar = [SFBar initFromDictionary:dictTemp withStreet:street];
        [street.bars addObject:bar];
    }
    
    return street;
}

@end
