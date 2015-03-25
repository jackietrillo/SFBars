//
//  SearchBaseTableViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsViewControllerBase.h"
#import "Bar.h"

@interface SearchBaseViewController : UITableViewController

- (void)configureCell:(UITableViewCell *)cell forBar:(Bar *)bar;

@end
