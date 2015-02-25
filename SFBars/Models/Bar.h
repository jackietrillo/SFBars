//
//  SFHotspot.h
//  SFStreets
//
//  Created by JACKIE TRILLO on 11/19/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BaseEntity.h"

@interface Bar: BaseEntity

@property (readonly, nonatomic) NSInteger barId;
@property (readonly, nonatomic) NSInteger districtId;
@property (readonly, nonatomic) NSInteger musicTypeId;
@property (readonly, nonatomic, strong) NSString* descrip;
@property (readonly, nonatomic, strong) NSString* address;
@property (readonly, nonatomic, strong) NSString* phone;
@property (readonly, nonatomic, strong) NSString* hours;
@property (readwrite, nonatomic, strong) NSString* imageUrl;
@property (readonly, nonatomic, strong) NSString* websiteUrl;
@property (readonly, nonatomic, strong) NSString* calendarUrl;
@property (readonly, nonatomic, strong) NSString* facebookUrl;
@property (readonly, nonatomic, strong) NSString* yelpUrl;
@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic, strong) NSArray* barTypes;

+(id)initFromDictionary:(NSDictionary*)dict;

@end
