//
//  Bar.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/19/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "Bar.h"

@interface Bar()

@property (readwrite, nonatomic) NSInteger barId;
@property (readwrite, nonatomic) NSInteger districtId;
@property (readwrite, nonatomic) NSInteger musicTypeId;
@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic, strong) NSString* descrip;
@property (readwrite, nonatomic, strong) NSString* address;
@property (readwrite, nonatomic, strong) NSString* phone;
@property (readwrite, nonatomic, strong) NSString* hours;
@property (readwrite, nonatomic, strong) NSString* websiteUrl;
@property (readwrite, nonatomic, strong) NSString* calendarUrl;
@property (readwrite, nonatomic, strong) NSString* facebookUrl;
@property (readwrite, nonatomic, strong) NSString* yelpUrl;
@property (readwrite, nonatomic) double latitude;
@property (readwrite, nonatomic) double longitude;
@property (readwrite, nonatomic, strong) District* district;

@end

@implementation Bar

static const NSString* BARID = @"barId";
static const NSString* DISTRICTID = @"districtId";
static const NSString* MUSICTYPEID = @"musicTypeId";
static const NSString* NAME = @"name";
static const NSString* DESCRIPTION = @"descrip";
static const NSString* ADDRESS = @"address";
static const NSString* PHONE = @"phone";
static const NSString* HOURS = @"hours";
static const NSString* LATITUDE = @"latitude";
static const NSString* LONGITUDE = @"longitude";
static const NSString* IMAGEURL = @"imageUrl";
static const NSString* WEBSITEURL = @"websiteUrl";
static const NSString* CALENDARURL = @"calendarUrl";
static const NSString* FACEBOOKURL = @"facebookUrl";
static const NSString* YELPURL = @"yelpUrl";

-(id)init
{
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    Bar* bar = [[Bar alloc] init];
    bar.barId = [dict[BARID] longValue];
    if (!dict[DISTRICTID]) {
        bar.districtId = [dict[DISTRICTID] longValue];
    }
    if (!dict[MUSICTYPEID]) {
        bar.musicTypeId = [dict[MUSICTYPEID] longValue];
    }
    bar.name = dict[NAME];
    bar.descrip = dict[DESCRIPTION];
    bar.address = dict[ADDRESS];
    bar.phone = dict[PHONE];
    bar.hours = dict[HOURS];
    bar.latitude = [dict[LATITUDE] doubleValue];
    bar.longitude = [dict[LONGITUDE] doubleValue];
    bar.imageUrl = dict[IMAGEURL];
    bar.websiteUrl = dict[WEBSITEURL];
    bar.calendarUrl = dict[CALENDARURL];
    bar.facebookUrl = dict[FACEBOOKURL];
    bar.yelpUrl = dict[YELPURL];
    return bar;
}

+(id)initFromDictionary:(NSDictionary*)dict withDistrict: (District*) district
{
    Bar* bar = [Bar initFromDictionary: dict];
  
    bar.district = district;

    return bar;
}
/*
- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.question = [decoder decodeObjectForKey:@"question"];
        self.categoryName = [decoder decodeObjectForKey:@"category"];
        bar.barId = dict[BARID];
        bar.streetId = dict[STREETID];
        bar.districtId = dict[DISTRICTID];
        bar.name = dict[NAME];
        bar.descrip = dict[DESCRIPTION];
        bar.address = dict[ADDRESS];
        bar.phone = dict[PHONE];
        bar.hours = dict[HOURS];
        bar.latitude = [dict[LATITUDE] doubleValue];
        bar.longitude = [dict[LONGITUDE] doubleValue];
        bar.imageUrl = dict[IMAGEURL];
        bar.websiteUrl = dict[WEBSITEURL];
        bar.calendarUrl = dict[CALENDARURL];
        bar.facebookUrl = dict[FACEBOOKURL];
        bar.yelpUrl = dict[YELPURL];

    }
    return self;
       
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.question forKey:@"question"];
    [encoder encodeObject:self.categoryName forKey:@"category"];
    [encoder encodeObject:self.subCategoryName forKey:@"subcategory"];
}
*/

@end