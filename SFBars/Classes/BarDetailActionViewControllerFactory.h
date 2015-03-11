//
//  BarsDetailActionViewControllerFactory.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/10/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarWebViewController.h"
#import "Bar.h"
#import "Enums.h"

@interface BarsDetailActionViewControllerFactory : NSObject

-(UIViewController*) controllerForAction: (BarDetailActionType)action withBar: (Bar*) bar;

@end
