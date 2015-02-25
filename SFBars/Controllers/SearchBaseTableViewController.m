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
    
    [self.tableView registerNib:[UINib nibWithNibName:kTableCellNibName bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)configureCell:(UITableViewCell *)cell forBar:(Bar *)bar {
    cell.textLabel.text = bar.name;
    
    cell.detailTextLabel.text = bar.descrip;
}

-(void)getBars {
    
    if (!self.appDelegate.cachedBars) {
        
        [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    }
    else {
        
        [self loadData:self.appDelegate.cachedBars];
    }
}

-(NSMutableArray*)parseData: (NSData*)responseData {
    
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray* bars = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0) {
        
        for (int i = 0; i < arrayData.count; i++) {
            
            NSDictionary* dictTemp = arrayData[i];
            
            Bar* bar = [Bar initFromDictionary:dictTemp];
            
            [bars addObject:bar];
        }
    }
    
    self.appDelegate.cachedBars = bars;
    
    return bars;
    
}


@end
