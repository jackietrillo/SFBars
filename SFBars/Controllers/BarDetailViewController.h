//
//  BarDetailsViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsViewControllerBase.h"
#import "BarDetailHeaderViewCell.h"
#import "BarWebViewController.h"
#import "TelephoneHelper.h"
#import "BarDetailItem.h"
#import "Bar.h"

@import MessageUI;

@interface BarDetailViewController : BarsViewControllerBase <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@property (readwrite, nonatomic, strong) Bar* selectedBar;

@end
