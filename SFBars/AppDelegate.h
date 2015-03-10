//
//  AppDelegate.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/11/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "BarsGateway.h"
#import "BarsManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic, strong) BarsGateway* barsGateway;
@property (readonly, nonatomic, strong) BarsManager* barsManager;

@end

