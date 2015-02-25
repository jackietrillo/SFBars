//
//  BarsGateway.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/22/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "AppDelegate.h"

@interface BarsGateway : NSObject

-(NSMutableArray*)getBars;
-(NSMutableArray*)getBarTypes;
-(NSMutableArray*)getDistricts;
-(NSMutableArray*)getParties;
-(NSMutableArray*)getEvents;
-(NSMutableArray*)getMusicTypes;
-(NSMutableArray*)getBarDetails;
-(NSMutableArray*)getMenuItems;
-(NSMutableArray*)getSettings;

@end
