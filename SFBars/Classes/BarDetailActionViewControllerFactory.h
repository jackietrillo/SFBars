//
//  BarsDetailActionViewControllerFactory.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/10/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

@import UIKit;
@import MessageUI;

#import "BarWebViewController.h"
#import "Bar.h"
#import "BarsEnums.h"

@interface BarDetailActionViewControllerFactory : NSObject

-(UIViewController*) viewControllerForAction: (BarDetailActionType)action withBar: (Bar*) bar;

@end
