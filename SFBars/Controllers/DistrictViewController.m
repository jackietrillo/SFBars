//
//  ViewController.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/11/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "DistrictViewController.h"
#import "StreetTableViewCell.h"


@interface DistrictViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation DistrictViewController

static NSString* reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initController];
}

-(void)initController {
   
 
    self.tableView.delegate = self;
    
    self.canDisplayBannerAds = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSInteger rowIndex = indexPath.row;
    
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier forIndexPath:indexPath];
    
   // cell.textLabel.text = street.name;
  
    return cell;
}




#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
      //  [self animateTableCells];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // [self animateTableCells];
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   //  NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    // BarViewController* barsViewController = segue.destinationViewController;
    // barsViewController.street = self.dataSource[indexPath.row];
 }

@end
