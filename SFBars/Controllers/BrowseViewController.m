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
@property (readwrite, nonatomic, strong) NSArray* barTypesData;

@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canDisplayBannerAds = YES;
   
    [self initNavigation];
   
    [self showLoadingIndicator];
   
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    
    [self.barsGateway getBarTypes: ^(NSArray* data) {
        if (data) {
            self.barTypesData = data;
            
            [self.tableView reloadData];
        }
        self.tableView.hidden = NO;
        [self hideLoadingIndicator];
    }];
}

-(void)initNavigation {
    
    [self addMenuButtonToNavigation];

    self.navigationItem.title = NSLocalizedString(@"BROWSE", @"BROWSE");
    [self.navigationController setToolbarHidden:YES animated:YES];
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
            return [self.barTypesData count];
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section) {
        case 0:
            
        if (indexPath.row < self.barTypesData.count) {
            BarType* barType = (BarType*)[self.barTypesData objectAtIndex:indexPath.row];
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
    
    BarType* barType = self.barTypesData[indexPath.row];
    
    barsViewController.titleText = barType.name;
    barsViewController.filterIds = @[[[NSNumber numberWithInteger:barType.itemId] stringValue]];
    barsViewController.filterType = FilterByBarTypes;
    
    // Hack to remove back button text on segued screen
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

@end
