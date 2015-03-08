//
//  AppDelegate.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/11/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "BarsGateway.h"
#import "BarType.h"
#import "Bar.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic, strong) BarsGateway* barsGateway;

// note: This is moving into Cache Object
@property (readwrite, nonatomic, strong) NSMutableArray* cachedBars;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedBarTypes;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedDistricts;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedParties;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedEvents;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedMusicTypes;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedBarDetails;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedMenuItems;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedSettings;

@end

