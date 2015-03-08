//
//  MusicType.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/18/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "Party.h"

@interface  Party()

@end

@implementation Party

static const NSString* PARTYID = @"PartyId";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    Party* party = [super initFromDictionary:dict forEntity:[[Party alloc] init]];
    party.partyId = [dict[PARTYID] longValue];
    
    return party;
}

@end