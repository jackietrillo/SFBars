//
//  SearchResultsTableViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import "SearchResultsViewController.h"


@implementation SearchResultsViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredBars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* tableViewCell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    Bar* bar = self.filteredBars[indexPath.row];
    
    [self configureCell:tableViewCell forBar:bar];
    
    return tableViewCell;
}

@end