//
//  TopListViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/30/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "TopListViewController.h"

@interface TopListViewController ()

@property (readwrite, nonatomic, strong) NSMutableArray* dataTopList;

@end

@implementation TopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavigation];
    
    [self getBars];
}

- (void)initNavigation {
    
   [super addMenuButtonToNavigation];
    
    self.navigationItem.title = NSLocalizedString(@"TOP LIST", @"TOP LIST");
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:kCellIdentifier style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//TODO move to gateway
-(void)getBars {
    
    if (!self.appDelegate.cachedBars) {
        [self sendAsyncRequest:kServiceUrl method:@"GET" accept:@"application/json"];
    }
    else {
        
        [self loadData:self.appDelegate.cachedBars];
    }
}

//TODO move to gateway
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

-(void)loadData: (NSMutableArray*) data {
    
    if (data) {
        self.tableView.hidden = NO;
        self.tableView.delegate = self;
        self.dataTopList = data;
        [self.tableView reloadData];
    }
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
     
     if ([segue.destinationViewController isKindOfClass: [BarDetailsViewController class]]) {
         BarDetailsViewController* barDetailsViewController = segue.destinationViewController;
         NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
         barDetailsViewController.selectedBar = self.dataTopList[indexPath.row];
     }
 }

@end
