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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    [self initController];
}

-(void)initController
{
    [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    
    self.tableView.hidden = YES;
    self.canDisplayBannerAds = YES;
    
    UIBarButtonItem *showMenuButton = [[UIBarButtonItem alloc] init];
    UIBarButtonItem* showSettingsButton = [[UIBarButtonItem alloc] init];
    
    [showSettingsButton setTarget:self];
    [showSettingsButton setAction:@selector(showSettings:)];
    
    [showMenuButton setTarget:self];
    [showMenuButton setAction:@selector(showMenu:)];
    
    UIFont* font = [UIFont fontWithName:@"fontawesome" size:28.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    [showSettingsButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [showSettingsButton setTitle:[NSString stringWithUTF8String:"\uf013"]];
    
    [showMenuButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [showMenuButton setTitle:[NSString stringWithUTF8String:"\uf039"]];
    
    self.navigationItem.leftBarButtonItem = showMenuButton;
    self.navigationItem.rightBarButtonItem = showSettingsButton;
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

-(NSMutableArray*)parseData: (NSData*)jsonData
{
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
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

-(void)loadData: (NSMutableArray*) data
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.tableView.delegate = self;
    self.data = data;
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.tableView.sectionIndexBackgroundColor =[ UIColor blueColor];
    [self.tableView reloadData];
    self.tableView.hidden = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return [self.data count];
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
        tempLabel.text = @"Brose";
    }
    
    [tempView addSubview:tempLabel];
    
    return tempView;
}


-(void)setCellStyle:(UITableViewCell *)cell
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
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

- (IBAction)unwindToBrowse:(UIStoryboardSegue *)unwindSegue
{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    BarViewController* barsViewController = segue.destinationViewController;
    BarType* barType = self.data[indexPath.row];
    barsViewController.barTypeId = barType.barTypeId;
}

- (void)showSettings:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)showMenu:(id)sender
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
