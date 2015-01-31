//
//  Menu.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MenuItem.h"

@interface  MenuItem()

@property (readwrite, nonatomic) NSString* name;
@property (readwrite, nonatomic) NSInteger menuItemId;
@property (readwrite, nonatomic) NSInteger section;
@property (readwrite, nonatomic) NSInteger statusFlag;
@end

@implementation MenuItem

static const NSString* MENUITEMID = @"menuItemId";
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
    MenuItem* menuItem = [[MenuItem alloc] init];
    menuItem.menuItemId = [dict[MENUITEMID] longValue];
    menuItem.section = [dict[SECTION] longValue];
    menuItem.name = dict[NAME];
    menuItem.imageUrl = dict[IMAGEURL];
    menuItem.statusFlag = [dict[STATUSFLAG] longValue];
    return menuItem;
}

@end
