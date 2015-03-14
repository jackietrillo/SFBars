//
//  TopListViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/30/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsViewControllerBase.h"
#import "AppDelegate.h"
#import "BarDetailViewController.h"
#import "Bar.h"

@interface TopListViewController : BarsViewControllerBase <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end
