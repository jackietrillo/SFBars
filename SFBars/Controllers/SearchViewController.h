//
//  TopListViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/30/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "BarDetailsViewController.h"
#import "SearchResultsViewController.h"
#import "Bar.h"
#import "Constants.h"

@interface SearchViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) IBOutlet UITableView* tableView;

@end
