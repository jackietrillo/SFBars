//
//  BarsGateway.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/22/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsGatewayBase.h"
#import "BarType.h"
#import "Bar.h"
#import "District.h"
#import "MusicType.h"
#import "Party.h"
#import "Event.h"

@interface BarsGateway : BarsGatewayBase

-(void)getBars:(BarsGatewayCompletionHandler) completionHandler;
-(void)getBarTypes: (BarsGatewayCompletionHandler) completionHandler;
-(void)getDistricts: (BarsGatewayCompletionHandler) completionHandler;
-(void)getMusicTypes: (BarsGatewayCompletionHandler) completionHandler;
-(void)getParties: (BarsGatewayCompletionHandler) completionHandler;
-(void)getEvents: (BarsGatewayCompletionHandler) completionHandler;

@end
