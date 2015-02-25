//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BrowseViewController.h"


@interface BrowseViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canDisplayBannerAds = YES;
    self.tableView.hidden = YES;

    [self initNavigation];
    [self loadTableViewData:[self getBarTypes]];
}

-(void)initNavigation {
    
    UIFont* font = [UIFont fontWithName: kGlyphIconsFontName size:25.0];
    NSDictionary* attributesForNormalState =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc] init];

    [menuButton setTitleTextAttributes: attributesForNormalState forState:UIControlStateNormal];
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    [menuButton setTarget:self];
    [menuButton setAction:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = menuButton;

    self.navigationItem.title = NSLocalizedString(@"BROWSE", @"BROWSE");
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    // Hack to remove back button text on segued screen
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(NSMutableArray*)getBarTypes {
    
    if (self.appDelegate.cachedBarTypes) {
        return self.appDelegate.cachedBarTypes;
    }
        
    NSString* path = [[NSBundle mainBundle] pathForResource:@"BarTypes" ofType:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfFile:path];
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    @try {
        
        NSMutableArray* dataByType = [[NSMutableArray alloc] init];
        
        if (arrayData.count > 0) {
            for (int i = 0; i < arrayData.count; i++) {
                NSDictionary* dictTemp = arrayData[i];
                BarType* barType = [BarType initFromDictionary:dictTemp];
                [dataByType addObject:barType];
            }
        }
        
        self.appDelegate.cachedBarTypes = dataByType;
        
        return dataByType;
        
    }
    @catch (NSException *exception) {
        
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Infromation", @"Infromation")
                                                            message: NSLocalizedString(@"Unable to retrieve data from server.", @"Unable to retrieve data from server.")
                                                           delegate: nil
                                                  cancelButtonTitle: NSLocalizedString(@"OK", @"OK")
                                                  otherButtonTitles:nil];
        
        [alertView show];
        
        return nil;
    }
    @finally {
    
        jsonData = nil;
    }
}

-(void)loadTableViewData:(NSMutableArray*) data {
    
    if (data) {
        self.data = data;
    
        self.tableView.hidden = NO;
        self.tableView.delegate = self;
        [self.tableView reloadData];
    }
}

-(void)setCellStyle:(UITableViewCell *)cell {
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
        case 0:
            return [self.data count];
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    switch(indexPath.section) {
        case 0:
            
        if (indexPath.row < self.data.count) {
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
    barsViewController.filterIds = @[[[NSNumber numberWithInteger:barType.itemId] stringValue]];
    barsViewController.filterType = FilterByBarTypes;
}

- (void)showMenu:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    MenuViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
