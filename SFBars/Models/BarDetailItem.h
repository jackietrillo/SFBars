//
//  Menu.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import "BaseItem.h"

@interface BarDetailItem : BaseItem

@property (nonatomic, strong) NSString* controller;

+(id)initFromDictionary:(NSDictionary*)dict;

@end
