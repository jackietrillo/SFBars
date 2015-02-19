//
//  Menu.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEntity.h"

@interface TableRowDataItem : BaseEntity

@property (readwrite, nonatomic) NSInteger section;

+(id)initFromDictionary:(NSDictionary*)dict;

@end
