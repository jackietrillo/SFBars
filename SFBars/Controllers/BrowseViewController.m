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

static const NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bartype/";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canDisplayBannerAds = YES;
    self.tableView.hidden = YES;

    [self initNavigation];
   
    if (!self.appDelegate.cachedBarTypes) {
        NSString* path = [[NSBundle mainBundle] pathForResource:@"BarTypes" ofType:@"json"];
        NSData* data = [NSData dataWithContentsOfFile:path];
        
        NSMutableArray* barTypesData  = [self parseData:data];
        [self loadData:barTypesData];
        data = nil;
    }
    else {
        [self loadData:self.appDelegate.cachedBarTypes];
    }
}

-(void)initNavigation {
    
    UIFont* font = [UIFont fontWithName:@"GLYPHICONSHalflings-Regular" size:25.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc] init];
    
    [menuButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    
    [menuButton setTarget:self];
    
    [menuButton setAction:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    
    self.navigationItem.title = NSLocalizedString(@"BROWSE", @"BROWSE");
                                                  
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
}

-(void)loadData:(NSMutableArray*) data {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (!data) {
        return;
    }
    
    if (!self.appDelegate.cachedBarTypes) {
        self.appDelegate.cachedBarTypes = data;
    }

    self.data = data;
    
    self.tableView.hidden = NO;
    
    self.tableView.delegate = self;
   
    [self.tableView reloadData];
    
}

-(NSMutableArray*)parseData:(NSData*)responseData {
    
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    
    @try {
       
        NSMutableArray* dataByType = [[NSMutableArray alloc] init];
        
        if (arrayData.count > 0) {
            for (int i = 0; i < arrayData.count; i++) {
                
                NSDictionary* dictTemp = arrayData[i];
                
                BarType* barType = [BarType initFromDictionary:dictTemp];
                
                [dataByType addObject:barType];
            }
        }
        
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
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
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
    
    MenuViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
