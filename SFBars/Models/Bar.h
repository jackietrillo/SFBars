//
//  SFHotspot.h
//  SFStreets
//
//  Created by JACKIE TRILLO on 11/19/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Street.h"

@interface Bar : NSObject

@property (readonly, nonatomic, strong) NSNumber* barId;
@property (readonly, nonatomic, strong) NSNumber* streetId;
@property (readonly, nonatomic, strong) NSString* name;
@property (readonly, nonatomic, strong) NSString* descrip;
@property (readonly, nonatomic, strong) NSString* address;
@property (readonly, nonatomic, strong) NSString* phone;
@property (readonly, nonatomic, strong) NSString* hours;
@property (readonly, nonatomic, strong) NSString* imageUrl;
@property (readonly, nonatomic, strong) NSString* websiteUrl;
@property (readonly, nonatomic, strong) NSString* facebookUrl;
@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic) Street* street;

+(id)initFromDictionary:(NSDictionary*)dict;

+(id)initFromDictionary:(NSDictionary*)dict withStreet: (Street*) street;


@end
