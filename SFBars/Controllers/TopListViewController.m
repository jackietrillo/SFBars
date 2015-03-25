//
//  TopListViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/30/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "TopListViewController.h"

@interface TopListViewController ()

@property (readwrite, nonatomic, strong) NSArray* dataTopList;

@end

@implementation TopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavigation];
    [self initTableView];
    
    [self.barsFacade getBars: ^(NSArray* data) {
        if (data) {
            self.dataTopList = data;
            [self.tableView reloadData];
        }
        self.tableView.hidden = NO;
        [self hideLoadingIndicator];
    }];
}

- (void)initNavigation {
    self.navigationItem.title = NSLocalizedString(@"TOP LIST", @"TOP LIST");
    
    // Hack to remove text in back button on segued view controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)initTableView {
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return [self.dataTopList count];
        default:
            return 0;
    }
}

-(void)setTableViewCellStyle:(UITableViewCell *)tableViewCell {
    UILabel* ranklabel = (UILabel*)[tableViewCell viewWithTag:1];
    UILabel* namelabel = (UILabel*)[tableViewCell viewWithTag:2];
    UILabel* descriplabel = (UILabel*)[tableViewCell viewWithTag:3];
    
    ranklabel.highlightedTextColor = [UIColor whiteColor];
    namelabel.highlightedTextColor = [UIColor grayColor];
    descriplabel.highlightedTextColor = [UIColor grayColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section) {
        case 0:
            if (indexPath.row < self.dataTopList.count) {
                Bar* bar = (Bar*)[self.dataTopList objectAtIndex:indexPath.row];
                
                UILabel* ranklabel = (UILabel*)[tableViewCell viewWithTag:1];
                UILabel* namelabel = (UILabel*)[tableViewCell viewWithTag:2];
                UILabel* descriplabel = (UILabel*)[tableViewCell viewWithTag:3];
                
                NSInteger rank = indexPath.row + 1;
                ranklabel.text = [NSString stringWithFormat:@"%d", (int)rank];
                namelabel.text = bar.name;
                descriplabel.text = bar.descrip;
               
                [self setTableViewCellStyle:tableViewCell];
            }
            break;
    }
    
    return tableViewCell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell* tableViewCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    tableViewCell.selectedBackgroundView = [[UIView alloc] init];
    tableViewCell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    //Hack because seperator disappears when cell is selected
    UIView* separatorLineTop = [[UIView alloc] initWithFrame:CGRectMake(10, 0, tableViewCell.bounds.size.width, 0.5)];
    separatorLineTop.backgroundColor = [UIColor yellowColor];
    
    [tableViewCell.selectedBackgroundView addSubview:separatorLineTop];
    
    //Hack because seperator disappears when cell is selected
    UIView* separatorLineBotton = [[UIView alloc] initWithFrame:CGRectMake(10, tableViewCell.bounds.size.height - 1, tableViewCell.bounds.size.width , 0.5)];
    separatorLineBotton.backgroundColor = [UIColor yellowColor];
    [tableViewCell.selectedBackgroundView addSubview:separatorLineBotton];
    
    return YES;
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
     if ([segue.destinationViewController isKindOfClass: [BarDetailViewController class]]) {
         BarDetailViewController* barDetailViewController = segue.destinationViewController;
         NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
         barDetailViewController.selectedBar = self.dataTopList[indexPath.row];
     }
 }

@end
