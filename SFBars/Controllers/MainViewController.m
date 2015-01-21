//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MainViewController.h"
#import "BarViewController.h"
#import "BarType.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* dataByType;
@property (readwrite, nonatomic, strong) NSMutableArray* dataByLocation;
@end

@implementation MainViewController

static NSString* reuseIdentifier = @"Cell";
static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bartype/";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    [self initController];
}

-(void)initController
{
    [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    
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
    
    self.dataByType = [[NSMutableArray alloc] init];
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++)
        {
            NSDictionary* dictTemp = arrayData[i];
            BarType* barType = [BarType initFromDictionary:dictTemp];
            [self.dataByType addObject:barType];
        }
    }
    
     self.dataByLocation = [[NSMutableArray alloc] init];
    [self.dataByLocation addObject:@"By Street"];
    [self.dataByLocation addObject:@"Mission"];
    [self.dataByLocation addObject:@"Castro"];
    [self.dataByLocation addObject:@"All"];

    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.sectionIndexBackgroundColor =[ UIColor blueColor];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return @"";
        case 1:
            return @"Search";
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return [self.dataByType count];
        case 1:
            return [self.dataByLocation count];
        default:
            return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
    tempView.backgroundColor=[UIColor blackColor];
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
    tempLabel.backgroundColor=[UIColor clearColor];
    tempLabel.shadowColor = [UIColor blackColor];
    tempLabel.shadowOffset = CGSizeMake(0,2);
    tempLabel.textColor = [UIColor blueColor]; //here you can change the text color of header.
  
    if(section == 0) {
        tempLabel.text = @"Search";
    }
    else {
        tempLabel.text = @"Location";
    }
    
    [tempView addSubview:tempLabel];
    
    return tempView;
}


-(void)setCellStyle:(UITableViewCell *)cell
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
   //cell.selectedBackgroundView.backgroundColor = [UIColor greenColor];
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
   //cell.imageView.highlightedImage = [UIImage imageNamed:@"DefaultImage-Bar"];
    cell.imageView.frame = CGRectMake(50,500,500,500);
    cell.indentationLevel = 0;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator
  
    [cell.detailTextLabel setTextColor:[UIColor grayColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section)
    {
        case 0:
            if (indexPath.row < self.dataByType.count)
            {
                BarType* barType = (BarType*)[self.dataByType objectAtIndex:indexPath.row];
                cell.textLabel.text = barType.name;
                cell.detailTextLabel.text = @"More text";
                [self setCellStyle:cell];
                
            }
            break;
        case 1:
            if (indexPath.row < self.dataByLocation.count)
            {
                cell.textLabel.text = [self.dataByLocation objectAtIndex:indexPath.row];
                [self setCellStyle:cell];
                cell.detailTextLabel.text = @"More text";
            }
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    BarViewController* barsViewController = segue.destinationViewController;
    BarType* barType = self.dataByType[indexPath.row];
    barsViewController.barTypeId = barType.barTypeId;
}


@end
