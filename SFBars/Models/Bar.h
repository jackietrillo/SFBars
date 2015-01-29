//
//  SFHotspot.h
//  SFStreets
//
//  Created by JACKIE TRILLO on 11/19/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BaseEntity.h"
#import "District.h"

@interface Bar: BaseEntity

@property (readonly, nonatomic, strong) NSNumber* barId;
@property (readonly, nonatomic, strong) NSNumber* streetId;
@property (readonly, nonatomic, strong) NSString* name;
@property (readonly, nonatomic, strong) NSString* descrip;
@property (readonly, nonatomic, strong) NSString* address;
@property (readonly, nonatomic, strong) NSString* phone;
@property (readonly, nonatomic, strong) NSString* hours;
@property (readwrite, nonatomic, strong) NSString* imageUrl;
@property (readonly, nonatomic, strong) NSString* websiteUrl;
@property (readonly, nonatomic, strong) NSString* calendarUrl;
@property (readonly, nonatomic, strong) NSString* facebookUrl;
@property (readonly, nonatomic, strong) NSString* yelpUrl;
//@property (readonly, nonatomic, strong) District* district;
@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;



+(id)initFromDictionary:(NSDictionary*)dict;

//+(id)initFromDictionary:(NSDictionary*)dict withDistrict: (District*) district;


@end
