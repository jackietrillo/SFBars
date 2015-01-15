//
//  Bar.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/19/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "Bar.h"
#import "Street.h"

@interface Bar()

@property (readwrite, nonatomic, strong) NSNumber* barId;
@property (readwrite, nonatomic, strong) NSNumber* streetId;
@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic, strong) NSString* descrip;
@property (readwrite, nonatomic, strong) NSString* address;
@property (readwrite, nonatomic, strong) NSString* phone;
@property (readwrite, nonatomic, strong) NSString* hours;
@property (readwrite, nonatomic, strong) NSString* imageUrl;
@property (readwrite, nonatomic, strong) NSString* websiteUrl;
@property (readwrite, nonatomic, strong) NSString* facebookUrl;
@property (readwrite, nonatomic) double latitude;
@property (readwrite, nonatomic) double longitude;
@property (readwrite, nonatomic) Street* street;

@end

@implementation Bar

static const NSString* BARID = @"sfBarId";
static const NSString* STREETID = @"sfStreetId";
static const NSString* NAME = @"name";
static const NSString* DESCRIPTION = @"descrip";
static const NSString* ADDRESS = @"address";
static const NSString* PHONE = @"phone";
static const NSString* HOURS = @"hours";
static const NSString* LATITUDE = @"latitude";
static const NSString* LONGITUDE = @"longitude";
static const NSString* IMAGEURL = @"imageUrl";
static const NSString* WEBSITEURL = @"websiteUrl";
static const NSString* FACEBOOKURL = @"facebookUrl";
static const NSString* STREET = @"sfStreet";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    Bar* bar = [[Bar alloc] init];
    bar.barId = dict[BARID];
    bar.streetId = dict[STREETID];
    bar.name = dict[NAME];
    bar.descrip = dict[DESCRIPTION];
    bar.address = dict[ADDRESS];
    bar.phone = dict[PHONE];
    bar.hours = dict[HOURS];
    bar.latitude = [dict[LATITUDE] doubleValue];
    bar.longitude = [dict[LONGITUDE] doubleValue];
    bar.imageUrl = dict[IMAGEURL];
    bar.websiteUrl = dict[WEBSITEURL];
    bar.facebookUrl = dict[FACEBOOKURL];
    
    bar.street = nil;
    return bar;
}

+(id)initFromDictionary:(NSDictionary*)dict withStreet: (Street*) street
{
    Bar* bar = [[Bar alloc] init];
    bar.barId = dict[BARID];
    bar.streetId = dict[STREETID];
    bar.name = dict[NAME];
    bar.descrip = dict[DESCRIPTION];
    bar.address = dict[ADDRESS];
    bar.phone = dict[PHONE];
    bar.hours = dict[HOURS];
    bar.latitude = [dict[LATITUDE] doubleValue];
    bar.longitude = [dict[LONGITUDE] doubleValue];
    bar.imageUrl = dict[IMAGEURL];
    bar.websiteUrl = dict[WEBSITEURL];
    bar.facebookUrl = dict[FACEBOOKURL];
    bar.street = street;
    return bar;
}

@end