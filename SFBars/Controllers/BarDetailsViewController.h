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
#import "Bar.h"

@interface BarDetailsViewController : UIViewController

@property (readwrite, nonatomic, strong) Bar* selectedBar;

@property (readwrite, nonatomic, weak) IBOutlet UIButton* backButton;

@property (readwrite, nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (readwrite, nonatomic, weak) IBOutlet UILabel* descripLabel;
@property (readwrite, nonatomic, weak) IBOutlet UILabel* addressLabel;
@property (readwrite, nonatomic, weak) IBOutlet UILabel* hoursLabel;

@property (readwrite, nonatomic, weak) IBOutlet UIButton* websiteButton;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* calendarButton;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* facebookButton;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* yelpButton;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* mapsButton;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* messageButton;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* emailButton;

@property (readwrite, nonatomic, weak) IBOutlet UIImageView* logo;

-(IBAction)tappedSendMail:(id)sender;
-(IBAction)tappedSendSMS:(id)sender;

@end
