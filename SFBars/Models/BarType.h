//
//  BarType.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"
#import "Bar.h"

@interface BarType : BaseEntity

+(id)initFromDictionary:(NSDictionary*)dict;

@end
