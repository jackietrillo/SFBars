//
//  ConnectionHelper.h
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/13/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionHelper : NSObject

-(NSData*) sendSyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept;
-(NSData*) sendAsyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept;

@end
