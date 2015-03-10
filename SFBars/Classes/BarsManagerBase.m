//
//  BaseBarsManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/9/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsManagerBase.h"

@implementation BarsManagerBase

-(NSArray*)getMenuItems {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(NSArray*)getBarDetailItems {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(NSArray*)getSettingsItems {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
