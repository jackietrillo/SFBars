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
    [self initBarTypesCollectionView];
    [self initBrowseMenuTableView];
    
    [self showLoadingIndicator];
    [self.barsFacade getBarTypes: ^(NSArray* data) {
        if (data) {
            self.barTypes = data;
            
            [self.barTypesCollectionView reloadData];
        }
        self.barTypesCollectionView.hidden = NO;
        [self hideLoadingIndicator];
    }];
    
    self.browseMenuItems = [self.barsFacade getBrowseMenuItems];
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
    self.barTypesCollectionView.backgroundColor = [UIColor blackColor];
}

-(void)initBarTypesCollectionView {
    self.barTypesCollectionView.hidden = YES;
    self.barTypesCollectionView.delegate = self;
    self.barTypesCollectionView.frame = CGRectMake(self.barTypesCollectionView.frame.origin.x - 10,
                                                   self.barTypesCollectionView.frame.origin.y - 10,
                                                   self.barTypesCollectionView.frame.size.width,
                                                   self.barTypesCollectionView.frame.size.height);
}

-(void)setBarTypesCollectionViewCellStyle:(UICollectionViewCell*)collectionViewCell {
    self.barTypesCollectionView.layer.borderWidth= 1.0f;
    self.barTypesCollectionView.layer.borderColor=[UIColor whiteColor].CGColor;
}

#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.barTypes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    UIImageView* imageView = (UIImageView*)[collectionViewCell viewWithTag:1];
    imageView.frame = collectionViewCell.bounds;
    imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    
    UILabel* textlabel = (UILabel*)[collectionViewCell viewWithTag:2];
    BarType* barType = (BarType*)self.barTypes[indexPath.row];
    textlabel.text = barType.name;
    
    [self setBarTypesCollectionViewCellStyle:collectionViewCell];
    
    return collectionViewCell;
}

-(void)setBrowseMenuTableViewCellStyle:(UITableViewCell *)tableViewCell {
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.textLabel.highlightedTextColor = [UIColor grayColor];
    tableViewCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}

#pragma UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.browseMenuItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    MenuItem* menuItem = (MenuItem*)self.browseMenuItems[rowIndex];
    
    tableViewCell.textLabel.text = menuItem.name;
    tableViewCell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];

    [self setBrowseMenuTableViewCellStyle:tableViewCell];
    
    return tableViewCell;
}

#pragma UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* navigationController = self.menuContainerViewController.centerViewController;
    
    MenuItem* menuItem = (MenuItem*)self.browseMenuItems  [rowIndex];
    
    if ([menuItem.name isEqualToString: NSLocalizedString(@"Top List", @"Top List")]){
        UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"TopListViewController"];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([menuItem.name isEqualToString: NSLocalizedString(@"By Neighborhood", @"By Neighborhood")]) {
        UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"DistrictViewController"];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([menuItem.name isEqualToString: NSLocalizedString(@"By Music", @"BY Music")]){
        UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MusicTypeViewController"];
        [navigationController pushViewController:vc animated:YES];
    }
    else if ([menuItem.name isEqualToString: NSLocalizedString(@"Parties", @"Parties")]){
        UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"PartyViewController"];
        [navigationController pushViewController:vc animated:YES];
    }
    
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}


@end
