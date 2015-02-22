//
//  BaseEntity.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/21/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseEntity.h"

@interface  BaseEntity()

@end

@implementation BaseEntity

static const NSString* ITEMID = @"itemId";
static const NSString* NAME = @"name";
static const NSString* IMAGEURL = @"imageUrl";
static const NSString* STATUSFLAG = @"statusFlag";

-(id)init {
    
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict forEntity:(BaseEntity*)baseEntity; {
    
    baseEntity.itemId = [dict[ITEMID] longValue];
    baseEntity.name = dict[NAME];
    baseEntity.imageUrl = dict[IMAGEURL];
    baseEntity.statusFlag = [dict[STATUSFLAG] longValue];
    
    return baseEntity;
}

@end
