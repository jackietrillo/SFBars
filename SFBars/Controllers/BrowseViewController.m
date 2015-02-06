//
//  MainViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BrowseViewController.h"
#import "AppDelegate.h"

@interface BrowseViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation BrowseViewController

static NSString* reuseIdentifier = @"Cell";
static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bartype/";

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self initController];
}

-(void)initController {
    self.tableView.hidden = YES;
    self.canDisplayBannerAds = YES;
   
    [self.navigationController setToolbarHidden:YES animated:YES];
   
    [self initNavigation];
    
    AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (delegate.cachedBarTypes == nil)
    {
        [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    }
    else
    {
        [self loadData:delegate.cachedBarTypes];
    }
}

-(void)initNavigation {
    //menu button
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
                 AppDelegate* delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                 if (delegate.cachedBarTypes == nil)
                 {
                     delegate.cachedBarTypes = arrayData;
                 }
                 
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

   
   // self.tableView.sectionIndexBackgroundColor =[ UIColor blueColor];
    [self.tableView reloadData];
    self.tableView.hidden = NO;
}

-(NSMutableArray*)parseData: (NSData*)jsonData {
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil)
    {
        //TODO: alert user
    }
    
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
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
   // cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator

    [cell.detailTextLabel setTextColor:[UIColor grayColor]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
  //  UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
}

#pragma mark - Navigation

- (IBAction)unwindToBrowse:(UIStoryboardSegue *)unwindSegue {
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    BarViewController* barsViewController = segue.destinationViewController;
    BarType* barType = self.data[indexPath.row];
    barsViewController.titleText = barType.name;
    barsViewController.bars = barType.bars;
}

- (void)showMenu:(id)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
