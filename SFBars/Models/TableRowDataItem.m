//
//  Menu.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/27/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "TableRowDataItem.h"

@interface  TableRowDataItem()

@end

@implementation TableRowDataItem

static const NSString* SECTION = @"section";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    TableRowDataItem* tableRowDataItem = [super initFromDictionary:dict forEntity:[[TableRowDataItem alloc] init]];
    tableRowDataItem.section = [dict[SECTION] longValue];
    return tableRowDataItem;
}

@end
