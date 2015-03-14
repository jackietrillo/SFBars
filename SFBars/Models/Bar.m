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
@property (readwrite, nonatomic, strong) NSArray* barTypes;

@end

@implementation Bar

static const NSString* BARID = @"barId";
static const NSString* DISTRICTID = @"districtId";
static const NSString* MUSICTYPEID = @"musicTypeId";
static const NSString* BARTYPES = @"barTypes";
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

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    Bar* bar = [[Bar alloc] init];
    
    bar.barId = [dict[BARID] longValue];
    
    if (dict[DISTRICTID]) {
        bar.districtId = [dict[DISTRICTID] longValue];
    }
    if (dict[MUSICTYPEID] && ![dict[MUSICTYPEID] isKindOfClass:[NSNull class]]) { // TODO fix api null
        bar.musicTypeId = [dict[MUSICTYPEID] longValue];
    }
    if (dict[BARTYPES]) {
        bar.barTypes = [dict[BARTYPES] componentsSeparatedByString: @","];
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

+(NSString*)getPropertyValueFromPropertyName:(NSString*)propertyName forBar:(Bar*)bar {
    
    if([propertyName isEqualToString: NSLocalizedString(@"Address", @"Address")]) {
        return bar.address;
    }
    else if ([propertyName isEqualToString: NSLocalizedString(@"Phone", @"Phone")]){
        return bar.phone;
    }
    else {
        return propertyName;
    }
}

@end


