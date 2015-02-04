//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "NearMeViewController.h"


@interface NearMeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation NearMeViewController

static NSString* reuseIdentifier = @"Cell";
static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/district/";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    [self initController];
}

-(void)initController {
    [self initNavigation];
    self.tableView.hidden = YES;
    self.canDisplayBannerAds = YES;
    [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
}

-(void)initNavigation {
    //menu button
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] init];
    
    UIFont* font = [UIFont fontWithName:@"GLYPHICONSHalflings-Regular" size:25.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    [menuButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    
    [menuButton setTarget:self];
    [menuButton setAction:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    self.navigationItem.title = @"NEAR ME"; //TODO: Localize
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

//TODO: move into helper class
-(void)sendAsyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:accept forHTTPHeaderField:@"Accept"];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue: queue
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         NSMutableArray* arrayData;
         if (connectionError == nil && data != nil)
         {
             arrayData = [self parseData:data];
         }
         else
         {
             //TODO: alert user
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (arrayData != nil)
             {
                 [self loadData: arrayData];
             }
             else
             {
                 //TODO: alert user
             }
         });
     }];
}

-(void)loadData: (NSMutableArray*) data {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.tableView.delegate = self;
    self.data = data;
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.tableView reloadData];
    self.tableView.hidden = NO;
}

-(NSMutableArray*)parseData: (NSData*)jsonData {
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
        //TODO: alert user
    }
    
    NSMutableArray* nearMeData = [[NSMutableArray alloc] init];
    if (arrayData.count > 0) {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            District* district = [District initFromDictionary:dictTemp];
            [nearMeData addObject:district];
        }
    }
    
    return nearMeData;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
    
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
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
    
    switch(section)
    {
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
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)setCellStyle:(UITableViewCell *)cell {
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    cell.imageView.frame = CGRectMake(50,500,500,500);
    cell.indentationLevel = 0;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section) {
        case 0:
            if (indexPath.row < self.data.count)
            {
                District* district = (District*)[self.data objectAtIndex:indexPath.row];
                cell.textLabel.text = district.name;
                
                [self setCellStyle:cell];
                
            }
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}

#pragma mark - Navigation

- (IBAction)unwindToBrowse:(UIStoryboardSegue *)unwindSegue
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    BarViewController* barsViewController = segue.destinationViewController;
    District* district = self.data[indexPath.row];
    barsViewController.titleText = district.name;
    barsViewController.bars = district.bars;
}

- (void)showSettings:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showMenu:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
