//
//  SearchBaseTableViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseViewController.h"

@class Bar;

@interface SearchBaseTableViewController : BaseViewController

@property (nonatomic, strong) IBOutlet UITableView* tableView;

- (void)configureCell:(UITableViewCell *)cell forBar:(Bar *)bar;

-(void)getBars;

@end
