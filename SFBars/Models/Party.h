//
//  MusicType.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/18/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseEntity.h"

@interface Party : BaseEntity

@property (readwrite, nonatomic) NSInteger partyId;

+(id)initFromDictionary:(NSDictionary*)dict;

@end