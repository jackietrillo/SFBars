//
//  Street.h
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
#import "Bar.h"

@interface District : BaseEntity

+(id)initFromDictionary:(NSDictionary*)dict;

@end
