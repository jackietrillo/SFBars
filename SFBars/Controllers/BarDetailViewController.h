//
//  BarDetailsViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseViewController.h"
#import "BarWebViewController.h"
#import "NearMeViewController.h"
#import "BarDetailHeaderViewCell.h"
#import "AppDelegate.h"
#import "BarDetailItem.h"
#import "Bar.h"
#import "Enums.h"

@interface BarDetailViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate,
                                                        MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@property (readwrite, nonatomic, strong) Bar* selectedBar;

@end
