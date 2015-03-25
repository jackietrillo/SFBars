//
//  BaseEntity.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/21/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

@import UIKit;

@interface BaseEntity : NSObject

@property (readwrite, nonatomic) NSInteger itemId;
@property (readwrite, nonatomic, strong) NSString* name;
@property (readwrite, nonatomic) NSInteger statusFlag;
@property (readwrite, nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) UIImage* icon;

+(id)initFromDictionary:(NSDictionary*)dict forEntity:(BaseEntity*)baseEntity;

@end
