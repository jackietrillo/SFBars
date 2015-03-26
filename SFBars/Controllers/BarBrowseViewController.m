//
//  BarBrowseViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/16/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarBrowseViewController.h"

@interface BarBrowseViewController ()

@property (readwrite, nonatomic, strong) NSArray* barTypes;
@property (readwrite, nonatomic, strong) NSArray* browseMenuItems;
@end

@implementation BarBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    
    [self initBrowseMenuTableView];
    
    self.browseMenuItems = [self.barsFacade getBrowseMenuItems];
    
    [self showLoadingIndicator];
    [self.barsFacade getBarTypes: ^(NSArray* data) {
        if (data) {
            self.barTypes = data;
            
            [self.browseMenuTableView reloadData];
        }
        self.browseMenuTableView.hidden = NO;
        [self hideLoadingIndicator];
    }];
}

-(void)initNavigation {
    [self addMenuButtonToNavigation];
    self.navigationItem.title = NSLocalizedString(@"BROWSE", @"BROWSE");
   
    // note Hack to remove text in back button on segued view controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)initBrowseMenuTableView {
    self.browseMenuTableView.delegate = self;
    self.eventsScrollView.backgroundColor  = [UIColor blackColor];
    self.browseMenuTableView.tableFooterView.backgroundColor = [UIColor blackColor];
    self.browseMenuTableView.tableHeaderView.backgroundColor = [UIColor blackColor];
}

-(void)setBrowseMenuTableViewCellStyle:(UITableViewCell *)tableViewCell {
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.textLabel.highlightedTextColor = [UIColor grayColor];
    tableViewCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}

#pragma UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 10.0;
        case 1:
            return 30.0;
        default:
            return 0;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor blackColor];
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor grayColor]];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @" ";
        case 1:
            return NSLocalizedString(@"SOCIAL & MOOD", @"SOCIAL & MOOD");
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [self.browseMenuItems count];
        case 1:
            return [self.barTypes count];
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
  
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
  
    if (indexPath.section == 0) {
        MenuItem* menuItem = (MenuItem*)self.browseMenuItems[rowIndex];
        tableViewCell.textLabel.text = menuItem.name;
        tableViewCell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];

        [self setBrowseMenuTableViewCellStyle:tableViewCell];
    } else {
    
        BarType* barType = (BarType*)self.barTypes[indexPath.row];
        tableViewCell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
        tableViewCell.textLabel.text = barType.name;
        
        [self setBrowseMenuTableViewCellStyle:tableViewCell];
    }
    return tableViewCell;
}

#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* navigationController = self.menuContainerViewController.centerViewController;

    if (indexPath.section == 0 ) {
        MenuItem* menuItem = (MenuItem*)self.browseMenuItems[rowIndex];
        
        UIViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:menuItem.controller];
        
        [navigationController pushViewController:viewController animated:YES];
        
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    } else {
        BarViewController* barsViewController = [storyboard instantiateViewControllerWithIdentifier:@"BarViewController"];
        BarType* barType = self.barTypes[indexPath.row];
        
        barsViewController.titleText = barType.name;
        barsViewController.filterIds = @[[[NSNumber numberWithInteger:barType.itemId] stringValue]];
        barsViewController.filterBy = BarsFilterByBarType;
        [navigationController pushViewController:barsViewController animated:YES];
        
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    }
}

@end
