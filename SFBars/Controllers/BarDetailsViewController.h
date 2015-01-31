//
//  BarDetailsViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>
#import "BarWebViewController.h"
#import "BarMapViewController.h"
#import "BarDetailItem.h"
#import "BarDetailHeaderViewCell.h"
#import "Bar.h"

@interface BarDetailsViewController : UIViewController

@property (readwrite, nonatomic, strong) Bar* selectedBar;







@end
