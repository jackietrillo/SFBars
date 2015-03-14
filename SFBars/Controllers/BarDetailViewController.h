//
//  BarDetailsViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsViewControllerBase.h"
#import "BarWebViewController.h"
#import "NearMeViewController.h"
#import "BarDetailHeaderViewCell.h"
#import "BarDetailActionViewControllerFactory.h"
#import "TelephoneHelper.h"
#import "BarDetailItem.h"
#import "BarsEnumParser.h"
#import "BarsEnums.h"
#import "Enums.h"
#import "Bar.h"

@interface BarDetailViewController : BarsViewControllerBase <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@property (readwrite, nonatomic, strong) Bar* selectedBar;

@end
