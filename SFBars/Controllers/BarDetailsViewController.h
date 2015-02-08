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
#import <MapKit/MapKit.h>
#import "BarWebViewController.h"
#import "NearMeViewController.h"
#import "BarDetailItem.h"
#import "BarDetailHeaderViewCell.h"
#import "Bar.h"

@interface BarDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>


@property (readwrite, nonatomic, strong) Bar* selectedBar;

@end
