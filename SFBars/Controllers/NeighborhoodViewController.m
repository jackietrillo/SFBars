//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "NeighborhoodViewController.h"


@interface NeighborhoodViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation NeighborhoodViewController

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/district/";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canDisplayBannerAds = YES;
    
    [self initNavigation];
    
    if (!self.appDelegate.cachedNeighborhoods) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"Districts" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        
        NSMutableArray* districts  = [self parseData:data];
        [self loadData:districts];
        
        data = nil; //TODO: Does this free memory?
    }
    else {
        [self loadData:self.appDelegate.cachedNeighborhoods];
    }
}

-(void)initNavigation {
   
    [self.navigationController setToolbarHidden:YES animated:YES];
    
   
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] init];
    
    UIFont* font = [UIFont fontWithName:@"GLYPHICONSHalflings-Regular" size:25.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    [menuButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    
    [menuButton setTarget:self];
    [menuButton setAction:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    self.navigationItem.title = @"NEIGHBORHOODS"; //TODO: Localize
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)loadData:(NSMutableArray*) data {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (!data) {
        return;
    }
    
    if (!self.appDelegate.cachedNeighborhoods) {
        self.appDelegate.cachedNeighborhoods = data;
    }
    
    self.tableView.hidden = NO;
    self.tableView.delegate = self;
    self.data = data;
    [self.tableView reloadData];
    
}

-(NSMutableArray*)parseData: (NSData*)jsonData {
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
        //TODO: alert user
    }
    
    NSMutableArray* districts = [[NSMutableArray alloc] init];
    if (arrayData.count > 0) {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            District* district = [District initFromDictionary:dictTemp];
            [districts addObject:district];
        }
    }
    
    return districts;
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

-(void)setCellStyle:(UITableViewCell *)cell {
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    BarViewController* barsViewController = segue.destinationViewController;
    District* district = self.data[indexPath.row];
    barsViewController.filterIds = @[[[NSNumber numberWithInteger:district.itemId] stringValue]];
    barsViewController.filterType = FilterByDistricts;
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
