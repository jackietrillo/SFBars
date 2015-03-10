//
//  TableCellDataItem.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/9/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseItem.h"

@implementation BaseItem

static const NSString* ITEMID = @"itemId";
static const NSString* NAME = @"name";
static const NSString* SECTION = @"section";
static const NSString* IMAGEURL = @"imageUrl";
static const NSString* STATUSFLAG = @"statusFlag";

-(id)init {
    
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict forItem:(BaseItem*)item {
    
    item.itemId = [dict[ITEMID] longValue];
    item.name = dict[NAME];
    item.section = [dict[SECTION] longValue];
    item.imageUrl = dict[IMAGEURL];
    item.statusFlag = [dict[STATUSFLAG] longValue];
    
    return item;
}

@end