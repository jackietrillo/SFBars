//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BrowseViewController.h"


@interface BrowseViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canDisplayBannerAds = YES;
    self.tableView.hidden = YES;

    [self initNavigation];
    [self loadTableViewData:[self getBarTypes]];
}


-(void)initNavigation {
    
    [super addMenuButtonToNavigation];

    self.navigationItem.title = NSLocalizedString(@"BROWSE", @"BROWSE");
    [self.navigationController setToolbarHidden:YES animated:YES];
}

// TODO refactor out
-(NSMutableArray*)getBarTypes {
    
    if (self.appDelegate.cachedBarTypes) {
        return self.appDelegate.cachedBarTypes;
    }
        
    NSString* path = [[NSBundle mainBundle] pathForResource:@"BarTypes" ofType:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfFile:path];
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    jsonData = nil;
  
        
    NSMutableArray* dataByType = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0) {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            BarType* barType = [BarType initFromDictionary:dictTemp];
            [dataByType addObject:barType];
        }
    }
    
    self.appDelegate.cachedBarTypes = dataByType;
    
    return dataByType;
}

-(void)loadTableViewData:(NSMutableArray*) data {
    
    if (data) {
        self.data = data;
    
        self.tableView.hidden = NO;
        self.tableView.delegate = self;
        [self.tableView reloadData];
    }
}

-(void)setTableViewCellStyle:(UITableViewCell *)tableViewCell {
    
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    
    tableViewCell.textLabel.highlightedTextColor = [UIColor blackColor];
    tableViewCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    tableViewCell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
        case 0:
            return [self.data count];
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section) {
        case 0:
            
        if (indexPath.row < self.data.count) {
            BarType* barType = (BarType*)[self.data objectAtIndex:indexPath.row];
            tableViewCell.textLabel.text = barType.name;
            
            [self setTableViewCellStyle:tableViewCell];
        }
        break;
    }
    
    return tableViewCell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    
    BarViewController* barsViewController = segue.destinationViewController;
    
    BarType* barType = self.data[indexPath.row];
    
    barsViewController.titleText = barType.name;
    barsViewController.filterIds = @[[[NSNumber numberWithInteger:barType.itemId] stringValue]];
    barsViewController.filterType = FilterByBarTypes;
    
    // Hack to remove back button text on segued screen
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

@end
