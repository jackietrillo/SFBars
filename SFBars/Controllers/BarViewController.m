//
//  StreetBarsViewController.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "Bar.h"
#import "BarViewController.h"
#import "BarTableViewCell.h"
#import "BarWebViewController.h"
#import "StreetMapViewController.h"

@interface BarViewController ()

@property (readwrite, nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation BarViewController

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bartype/";

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initController];
}

-(void)initController
{
    NSString* barTypeUrl = [serviceUrl stringByAppendingString:[self.barTypeId stringValue]];
    
    [self sendAsyncRequest:barTypeUrl method:@"GET" accept:@"application/json"];
  
    self.canDisplayBannerAds = YES;

}

-(void)sendAsyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:accept forHTTPHeaderField:@"Accept"];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue: queue
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (connectionError == nil)
             {
                 [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                 [self loadData:data];
             }
             else
             {
                 //TODO: check error type and alert user
             }
         });
     }];
}

-(void)loadData: (NSData*)data
{
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
       //TODO: alert user
    }
    
    NSMutableArray* bars = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++)
        {
            NSDictionary* dictTemp = arrayData[i];
            Bar* bar = [Bar initFromDictionary:dictTemp];
            [bars addObject:bar];
        }
    }

    self.dataSource = bars;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (IBAction)unwindToBar:(UIStoryboardSegue *)unwindSegue
{
    
}

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
