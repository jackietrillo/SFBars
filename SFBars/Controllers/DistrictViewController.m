//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "DistrictViewController.h"


@interface DistrictViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSArray* districtsData;

@end

@implementation DistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canDisplayBannerAds = YES;
    
    [self initNavigation];
    
    [self showLoadingIndicator];
    
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    
    [self.barsGateway getDistricts: ^(NSArray* data) {
        if (data) {
            self.districtsData = data;
            
            [self.tableView reloadData];
        }
        self.tableView.hidden = NO;
        [self hideLoadingIndicator];
    }];
}

-(void)initNavigation {
   
   [super addMenuButtonToNavigation];
    
    self.navigationItem.title = NSLocalizedString(@"NEIGHBORHOODS", @"NEIGHBORHOODS");
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0)];
    
    switch(section) {
        case 0:
            [headerView setBackgroundColor:[UIColor blackColor]];
            break;

        default:
            break;
    }
    return headerView;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0)];
    
    switch(section) {
        case 0:
            [footerView setBackgroundColor:[UIColor blackColor]];
            break;
            
        default:
            break;
    }
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)setTableViewCellStyle:(UITableViewCell *)tableViewCell {
    
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.textLabel.highlightedTextColor = [UIColor blackColor];
    tableViewCell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    tableViewCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section) {
        case 0:
            if (indexPath.row < self.districtsData.count) {
                District* district = (District*)[self.districtsData objectAtIndex:indexPath.row];
                cell.textLabel.text = district.name;
                [self setTableViewCellStyle:cell];
                
            }
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.districtsData.count;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    
    BarViewController* barsViewController = segue.destinationViewController;
    
    District* district = self.districtsData[indexPath.row];
    
    barsViewController.filterType = FilterByDistricts;
    barsViewController.filterIds = @[[[NSNumber numberWithInteger:district.itemId] stringValue]];
    
    // Hack to remove back button text on segued screen
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}


@end
