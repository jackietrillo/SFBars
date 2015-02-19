//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BrowseViewController.h"


@interface BrowseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation BrowseViewController

static NSString* reuseIdentifier = @"Cell";
static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bartype/";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    self.canDisplayBannerAds = YES;
    self.tableView.hidden = YES;

    if (!self.appDelegate.cachedBarTypes) {
        [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    }
    else {
        [self loadData:self.appDelegate.cachedBarTypes];
    }
}

-(void)initNavigation {
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc] init];
    
    UIFont* font = [UIFont fontWithName:@"GLYPHICONSHalflings-Regular" size:25.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    [menuButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    
    [menuButton setTarget:self];
    [menuButton setAction:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    self.navigationItem.title = @"BROWSE"; //TODO: Localize
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
}

-(void)loadData: (NSMutableArray*) data {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (!data) {
        return;
    }
    
    if (!self.appDelegate.cachedBarTypes) {
        self.appDelegate.cachedBarTypes = data;
    }

    self.tableView.hidden = NO;
    self.tableView.delegate = self;
    self.data = data;
    [self.tableView reloadData];
    
}

-(NSMutableArray*)parseData: (NSData*)responseData {
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&errorData];
    
    @try {
       
        NSMutableArray* dataByType = [[NSMutableArray alloc] init];
        if (arrayData.count > 0)
        {
            for (int i = 0; i < arrayData.count; i++)
            {
                NSDictionary* dictTemp = arrayData[i];
                BarType* barType = [BarType initFromDictionary:dictTemp];
                [dataByType addObject:barType];
            }
        }
        return dataByType;

    }
    @catch (NSException *exception) {
        //TODO: localize
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Infromation"
                                                            message:@"Unable to retrieve data at this time. Please try again later."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
        
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section)
    {
        case 0:
            return [self.data count];
        default:
            return 0;
    }
}

-(void)setCellStyle:(UITableViewCell *)cell {
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section)
    {
        case 0:
        if (indexPath.row < self.data.count)
        {
            BarType* barType = (BarType*)[self.data objectAtIndex:indexPath.row];
            cell.textLabel.text = barType.name;
           
            [self setCellStyle:cell];
        }
        break;
    }
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    BarViewController* barsViewController = segue.destinationViewController;
    BarType* barType = self.data[indexPath.row];
    barsViewController.titleText = barType.name;
    barsViewController.filterId = barType.barTypeId;
    //barsViewController.filterType = FilterByNotAssigned;
}

- (void)showMenu:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
