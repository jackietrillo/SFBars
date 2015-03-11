//
//  SearchTableViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailViewController.h"
#import "SearchBaseViewController.h"
#import "SearchResultsViewController.h"
#import "Bar.h"

@interface SearchViewController : SearchBaseViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, copy) NSArray *bars;

@end
