//
//  GatewayBase.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/22/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

@interface BarsGatewayBase : NSObject

typedef void (^BarsGatewayCompletionHandler) (NSArray* result);

-(void)getBars: (BarsGatewayCompletionHandler) completionHandler;
-(void)getBarTypes: (BarsGatewayCompletionHandler) completionHandler;
-(void)getDistricts: (BarsGatewayCompletionHandler) completionHandler;
-(void)getMusicTypes: (BarsGatewayCompletionHandler) completionHandler;
-(void)getParties: (BarsGatewayCompletionHandler) completionHandler;
-(void)getEvents: (BarsGatewayCompletionHandler) completionHandler;

@end
