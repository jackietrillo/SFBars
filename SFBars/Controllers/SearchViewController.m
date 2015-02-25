//
//  TopListViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/30/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()  

@property (readwrite, nonatomic, strong) NSMutableArray* data;
@property (readwrite, nonatomic, strong) NSMutableArray* searchResults;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation SearchViewController

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bar/";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    
    if (!self.appDelegate.cachedBars) {
        [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    }
    else {
        [self loadData: self.appDelegate.cachedBars];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%@", NSStringFromClass ([self class]));
}

- (void)initNavigation {
    
    self.navigationItem.title = NSLocalizedString(@"SEARCH", @"SEARCH");
}

-(void)loadData: (NSMutableArray*) data {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (!self.appDelegate.cachedBars) {
        self.appDelegate.cachedBars = data;
    }
    
    self.data = data;
    self.tableView.hidden = NO;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [self configureSearch];
    
}

-(NSMutableArray*)parseData: (NSData*)jsonData {
    
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray* data = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0) {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            Bar* bar = [Bar initFromDictionary:dictTemp];
            [data addObject:bar];
        }
    }
    return data;
}

-(void)configureSearch {

    self.searchResults = [NSMutableArray arrayWithCapacity:[self.data count]];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    
    self.tableView.tableHeaderView = self.searchController.searchBar;

    self.definesPresentationContext = YES;
}

-(void)setTableViewCellStyle:(UITableViewCell *)tableViewCell {
    
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    [tableViewCell.detailTextLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.detailTextLabel.numberOfLines = 0;
    tableViewCell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [tableViewCell.detailTextLabel sizeToFit];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.searchController.active) {
        return [self.searchResults count];
    } else {
        return [self.data count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section) {
        case 0:
        if (indexPath.row < self.data.count) {
            
            Bar* bar;
            
            if (self.searchController.active) {
                bar = [self.searchResults objectAtIndex:indexPath.row];
            } else {
                bar = [self.data objectAtIndex:indexPath.row];
            }
            
            tableViewCell.textLabel.text = bar.name;
            tableViewCell.detailTextLabel.text = bar.descrip;
            
            [self setTableViewCellStyle:tableViewCell];
        }
        break;
    }
    
    return tableViewCell;
}

#pragma mark - UISearchResultsUpdating

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = [self.searchController.searchBar text];

    [self updateFilteredContent:searchString];
    
    [self.tableView reloadData];
}


#pragma mark - Content Filtering

- (void)updateFilteredContent:(NSString *)barName {
    
    [self.searchResults removeAllObjects];
    
    for (Bar *bar in self.data) {
        
        NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
        
        NSRange barNameRange = NSMakeRange(0, bar.name.length);
        
        NSRange foundRange = [bar.name rangeOfString:barName options:searchOptions range:barNameRange];
        
        if (foundRange.length > 0) {
            [self.searchResults addObject:bar];
        }
    }
}


#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([segue.destinationViewController isKindOfClass: [BarDetailsViewController class]]) {
         
         BarDetailsViewController* barDetailsViewController = segue.destinationViewController;
         
         NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
         
         barDetailsViewController.selectedBar = self.data[indexPath.row];
     }
 }

@end
