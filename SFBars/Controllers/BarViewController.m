//
//  StreetBarsViewController.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BarManager.h"
#import "Bar.h"
#import "BarViewController.h"
#import "BarTableViewCell.h"
#import "BarWebViewController.h"
#import "StreetMapViewController.h"

@interface BarViewController ()

@property (readwrite, nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation BarViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initController];
}

- (IBAction)unwindToBar:(UIStoryboardSegue *)unwindSegue
{
}

-(void)initController {
    self.canDisplayBannerAds = YES;
    
    BarManager* barManager = [[BarManager alloc] init];
    
   // self.dataSource = [[NSMutableArray alloc] init];
    
    self.dataSource = [barManager getBarsByBarType: self.barTypeId];
 
    /*
    for (int i = 0 ; i < bars.count; i++) {
        Bar* tempBar = bars[i];
        
        if (tempBar.streetId == self.barTypeId)
        {
            [self.dataSource addObject:tempBar];
        }
    }*/
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    Bar* bar = self.dataSource[rowIndex];
    
    BarTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.nameLabel.text = bar.name;
    cell.descripLabel.text = bar.descrip;
    cell.addressLabel.text = bar.address;
    cell.hoursLabel.text = bar.hours;
    cell.websiteButton.tag = indexPath.row;
    cell.mapButton.tag = indexPath.row;
    
   // [cell.websiteButton setTitle: bar.websiteUrl forState:UIControlStateNormal];
    NSString* imageName = [bar.imageUrl substringToIndex: bar.imageUrl.length - 4]; //minus .png
   
    if (imageName != nil) {
        
        UIImage* image = [UIImage imageNamed:imageName];
        
        if (image == nil)
        {
            image = [UIImage imageNamed:@"DefaultImage-Bar"];
        }
        cell.logo.image = image;
     
    }
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  BarTableViewCell *cell = (BarTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
   // [self setCellColor:[UIColor yellowColor] ForCell:cell];  //highlight colour
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Reset Colour.
    //BarTableViewCell *cell = (BarTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
   // [self setCellColor:[UIColor blackColor] ForCell:cell]; //normal color
    
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = color;
    [cell setSelectedBackgroundView:bgColorView];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass: [BarWebViewController class]])
    {
        BarWebViewController* barWebViewController = segue.destinationViewController;
        UIButton* button = (UIButton*)(sender);
        Bar* bar = self.dataSource[button.tag]; //tag contains the NSIndexPath.row
        barWebViewController.url = bar.websiteUrl;
    }
    if ([segue.destinationViewController isKindOfClass: [StreetMapViewController class]])
    {
        StreetMapViewController* streetMapViewController = segue.destinationViewController;
        UIButton* button = (UIButton*)(sender);
        Bar* bar = self.dataSource[button.tag]; //tag contains the NSIndexPath.row
      //  streetMapViewController.street = bar.street;
        streetMapViewController.selectedBar = bar;
    }
}
/*
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    //NSLog(@"Trait collection = %@", newCollection);
}
*/
@end
