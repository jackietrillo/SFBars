//
//  BarManager.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarManager : NSObject

-(NSMutableArray* )getBarsByBarType: (NSNumber*)barTypeId;

@end