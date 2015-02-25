//
//  SearchBaseTableViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import "SearchBaseTableViewController.h"
#import "Bar.h"
#import "AppDelegate.h"

NSString* const kTableCellNibName = @"SearchTableViewCell";
static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bar/";

@interface SearchBaseTableViewController()

@property (nonatomic, strong) AppDelegate* appDelegate;

@end

@implementation SearchBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  
    
    [self.tableView registerNib:[UINib nibWithNibName: kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)configureCell:(UITableViewCell *)cell forBar:(Bar *)bar {
    cell.textLabel.text = bar.name;
    
    cell.detailTextLabel.text = bar.descrip;
}





@end
