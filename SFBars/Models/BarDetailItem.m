//
//  Menu.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailItem.h"

@interface  BarDetailItem()

@property (readwrite, nonatomic) NSString* name;
@property (readwrite, nonatomic) NSInteger barDetailItemId;
@property (readwrite, nonatomic) NSInteger section;
@property (readwrite, nonatomic) NSInteger statusFlag;
@end

@implementation BarDetailItem

static const NSString* BARDETAILITEMID = @"barDetailItemId";
static const NSString* SECTION = @"section";
static const NSString* NAME = @"name";
static const NSString* IMAGEURL = @"imageUrl";
static const NSString* STATUSFLAG = @"statusFlag";

-(id)init
{
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict
{
    BarDetailItem * barDetailItem = [[BarDetailItem alloc] init];
    barDetailItem.barDetailItemId = [dict[BARDETAILITEMID] longValue];
    barDetailItem.section = [dict[SECTION] longValue];
    barDetailItem.name = dict[NAME];
    barDetailItem.imageUrl = dict[IMAGEURL];
    barDetailItem.statusFlag = [dict[STATUSFLAG] longValue];
    return barDetailItem;
}

@end
