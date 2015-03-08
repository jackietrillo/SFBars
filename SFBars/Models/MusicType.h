//
//  MusicType.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/18/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableRowDataItem.h"

@interface MusicType : BaseEntity

@property (readwrite, nonatomic) NSInteger musicTypeId;

+(id)initFromDictionary:(NSDictionary*)dict;

@end