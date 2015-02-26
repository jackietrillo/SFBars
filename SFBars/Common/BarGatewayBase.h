//
//  GatewayBase.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/22/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


@interface BarGatewayBase : NSObject

-(NSArray*)getBars;
-(NSArray*)getBarTypes;
-(NSArray*)getDistricts;
-(NSArray*)getParties;
-(NSArray*)getEvents;
-(NSArray*)getMusicTypes;
-(NSArray*)getBarDetails;
-(NSArray*)getMenuItems;
-(NSArray*)getSettings;

@end