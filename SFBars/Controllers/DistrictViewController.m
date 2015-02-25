//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "DistrictViewController.h"


@interface DistrictViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation DistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.canDisplayBannerAds = YES;
    
    [self initNavigation];
    [self loadTableViewData: [self getDistricts]];
}

-(void)initNavigation {
   
    UIFont* font = [UIFont fontWithName: kGlyphIconsFontName size:25.0];
    NSDictionary* attributesForNormalState =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] init];
    
    [menuButton setTitleTextAttributes: attributesForNormalState forState:UIControlStateNormal];
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    [menuButton setTarget:self];
    [menuButton setAction:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    self.navigationItem.title = NSLocalizedString(@"NEIGHBORHOODS", @"NEIGHBORHOODS");
     [self.navigationController setToolbarHidden:YES animated:YES];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

//TODO move to gateway
-(NSMutableArray*)getDistricts {
    
    if (self.appDelegate.cachedDistricts) {
        return self.appDelegate.cachedDistricts;
    }
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Districts" ofType:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfFile:path];
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    jsonData = nil;
    
    NSMutableArray* districts = [[NSMutableArray alloc] init];
    if (arrayData.count > 0) {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            District* district = [District initFromDictionary:dictTemp];
            [districts addObject:district];
        }
    }
    
    self.appDelegate.cachedDistricts = districts;
    
    return districts;
}

-(void)loadTableViewData:(NSMutableArray*) data {
    
    if (data) {
        self.tableView.hidden = NO;
        self.tableView.delegate = self;
        self.data = data;
        [self.tableView reloadData];
    }
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

-(void)setTableViewCellStyle:(UITableViewCell *)tableViewCell {
    
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.textLabel.highlightedTextColor = [UIColor blackColor];
    tableViewCell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    tableViewCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section) {
        case 0:
            if (indexPath.row < self.data.count) {
                District* district = (District*)[self.data objectAtIndex:indexPath.row];
                cell.textLabel.text = district.name;
                [self setTableViewCellStyle:cell];
                
            }
            break;
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    
    BarViewController* barsViewController = segue.destinationViewController;
    
    District* district = self.data[indexPath.row];
    
    barsViewController.filterType = FilterByDistricts;
    
    barsViewController.filterIds = @[[[NSNumber numberWithInteger:district.itemId] stringValue]];
    
}

- (void)showSettings:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* settingsViewController = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)showMenu:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* menuViewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self.navigationController pushViewController:menuViewController animated:YES];
}

@end
