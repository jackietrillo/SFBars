//
//  TableCellDataItem.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/9/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


@interface BaseItem : NSObject

@property (readwrite, nonatomic) NSInteger itemId;
@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic) NSInteger section;
@property (readwrite, nonatomic, strong) NSString* imageUrl;
@property (readwrite, nonatomic) NSInteger statusFlag;

+(id)initFromDictionary:(NSDictionary*)dict forItem:(BaseItem*)item;

@end
