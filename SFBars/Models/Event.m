//
//  MusicType.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/18/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "Event.h"

@interface  Event()

@end

@implementation Event

static const NSString* EVENTID = @"eventId";

-(id)init {
    self = [super init];
    
    return self;
}

+(id)initFromDictionary:(NSDictionary*)dict {
    
    Event* event = [super initFromDictionary:dict forEntity:[[Event alloc] init]];
    event.eventId = [dict[EVENTID] longValue];
    
    return event;
}

@end