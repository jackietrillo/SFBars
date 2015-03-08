//
//  MusicType.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/18/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MusicType.h"

@interface  MusicType()

@end

@implementation MusicType

static const NSString* MUSICTYPEID = @"musicTypeId";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    MusicType* musicType = [super initFromDictionary:dict forEntity:[[MusicType alloc] init]];
    musicType.musicTypeId = [dict[MUSICTYPEID] longValue];
    
    return musicType;
}

@end