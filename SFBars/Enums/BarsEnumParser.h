//
//  EnumParser.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsEnums.h"

@interface BarsEnumParser : NSObject

+(BarDetailActionType)enumFromString:(NSString*)action;

@end
