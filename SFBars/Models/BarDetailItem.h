//
//  Menu.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface BarDetailItem : BaseEntity

@property (readonly, nonatomic) NSInteger barDetailItemId;
@property (readonly, nonatomic, strong) NSString* name;
@property (readonly, nonatomic) NSInteger section;
@property (readonly, nonatomic) NSInteger statusFlag;

+(id)initFromDictionary:(NSDictionary*)dict;

@end
