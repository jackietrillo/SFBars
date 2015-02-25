//
//  SearchTableViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailsViewController.h"
#import "SearchBaseTableViewController.h"
#import "SearchResultsTableViewController.h"
#import "Bar.h"

@interface SearchTableViewController : SearchBaseTableViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, copy) NSArray *bars;

@end
