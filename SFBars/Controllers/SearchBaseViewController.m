//
//  SearchBaseTableViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//


#import "SearchBaseViewController.h"
#import "Bar.h"
#import "AppDelegate.h"

@interface SearchBaseViewController()

@property (nonatomic, strong) AppDelegate* appDelegate;

@end

@implementation SearchBaseViewController

NSString* const kTableCellNibName = @"SearchTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
  
    [self.tableView registerNib:[UINib nibWithNibName: kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)configureCell:(UITableViewCell *)cell forBar:(Bar *)bar {
    cell.textLabel.text = bar.name;
    cell.detailTextLabel.text = bar.descrip;
    
    [self setTableViewCellStyle:cell];
}

-(void)setTableViewCellStyle:(UITableViewCell *)cell {
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.detailTextLabel setTextColor:[UIColor grayColor]];
    
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}


@end
