//
//  Street.h
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Street : NSObject

@property (readonly, nonatomic, strong) NSNumber* streetId;
@property (readonly, nonatomic, strong) NSString* name;
@property (readonly, nonatomic, strong) NSString* descrip;
@property (readonly, nonatomic, strong) NSString* imageUrl;
@property (readonly, nonatomic) double latitude;
@property (readonly, nonatomic) double longitude;
@property (readonly, nonatomic, strong) NSMutableArray* bars;

+(id)initFromDictionary:(NSDictionary*)dict;

@end
