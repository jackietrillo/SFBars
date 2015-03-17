//
//  SearchResultsTableViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import "SearchBaseViewController.h"
#import "Bar.h"

@interface SearchResultsViewController : SearchBaseViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *filteredBars;

@end
