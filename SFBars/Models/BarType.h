//
//  BarType.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarType : NSObject

@property (readonly, nonatomic, strong) NSNumber* barTypeId;
@property (readonly, nonatomic, strong) NSString* name;
@property (readonly, nonatomic, strong) NSString* imageUrl;
//@property (readonly, nonatomic, strong) NSMutableArray* bars;

+(id)initFromDictionary:(NSDictionary*)dict;

@end
