//
//  BarDetailsViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailsViewController.h"

@interface BarDetailsViewController () <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* dataDetail;
@property (readwrite, nonatomic, strong) NSMutableArray* dataFavorite;
@property (readwrite, nonatomic, strong) NSMutableArray* dataShare;
@end

@implementation BarDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self initController];
}

-(void)initController
{
    [self initNavigation];
    
    [self loadData];
    
    NSArray* xib = [[NSBundle mainBundle] loadNibNamed:@"BarDetailHeaderViewCell" owner:nil options:nil];
    
    BarDetailHeaderViewCell* headerView = [xib lastObject];
    headerView.frame = CGRectMake(0, 0, 150, 150);
    if (self.selectedBar.icon != nil)
    {
        headerView.logo.image = self.selectedBar.icon;
    }
    else
    {
        headerView.logo.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    }
    self.tableView.tableHeaderView = headerView;
}

- (void)initNavigation
{
    self.navigationItem.title = [self.selectedBar.name uppercaseString];
}

-(void)loadData
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"BarDetail" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    [self parseData:data];
}

-(void)parseData: (NSData*)jsonData
{
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil)
    {
        //TODO: Alert User
    }
    
    self.dataDetail = [[NSMutableArray alloc] init];
    self.dataFavorite = [[NSMutableArray alloc] init];
    self.dataShare = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++)
        {
            NSDictionary* dictTemp = arrayData[i];
            BarDetailItem* item = [BarDetailItem initFromDictionary: dictTemp];
            
            if (item.section == 0 && item.statusFlag == 1)
            {
                [self.dataDetail addObject:item];
            }
            else if (item.section == 1 && item.statusFlag == 1)
            {
                [self.dataFavorite addObject:item];
            }
            else if (item.section == 2 && item.statusFlag == 1)
            {
                [self.dataShare addObject:item];
            }
        }
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
    headerView.backgroundColor = [UIColor blackColor];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, tableView.bounds.size.width - 10, 50)];
    titleLabel.font = [UIFont fontWithName: @"Helvetica Neuve" size: 8.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLabel];
    
    switch(section)
    {
        case 0:
            titleLabel.text = self.selectedBar.descrip;
            break;
        case 1:
            titleLabel.text = @"Favorite";
            break;
        case 2:
            titleLabel.text = @"Share";
            break;
        default:
            break;;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return 50;
        case 1:
            return 30;
        case 2:
            return 30;
        default:
            return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return [self.dataDetail count];
        case 1:
            return [self.dataFavorite count];
        case 2:
            return [self.dataShare count];
        default:
            return 0;
    }
}

-(void)setCellStyle:(UITableViewCell *)cell
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowIndex = indexPath.row;
    BarDetailItem* dataItem;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    switch(indexPath.section)
    {
        case 0:
            dataItem = (BarDetailItem*)self.dataDetail[rowIndex];
            cell.textLabel.text = dataItem.name;
            cell.imageView.image = [UIImage imageNamed:dataItem.imageUrl];
            break;
        case 1:
            dataItem = (BarDetailItem*)self.dataFavorite[rowIndex];
            cell.textLabel.text = dataItem.name;
            cell.imageView.image = [UIImage imageNamed:dataItem.imageUrl];
            break;
        case 2:
            dataItem = (BarDetailItem*)self.dataShare[rowIndex];
            cell.textLabel.text = dataItem.name;
            cell.imageView.image = [UIImage imageNamed:dataItem.imageUrl];
            break;
        default:
            break;
    }
    
    if (cell.imageView.image == nil)
    {
        cell.imageView.image = [UIImage imageNamed:@"Icon-Search"];
    }
    
    [self setCellStyle:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowIndex = indexPath.row;
    BarDetailItem* dataItem;
    
    switch(indexPath.section)
    {
        case 0:
            dataItem = (BarDetailItem*)self.dataDetail[rowIndex];
            
            if (dataItem.barDetailItemId == 1)
            {
               // UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
               // BrowseViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BrowseViewController"];
               // [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([dataItem.name isEqualToString:@"Near Me"])
            {

            }
            else if ([dataItem.name isEqualToString:@"Top List"])
            {
            }
            else if ([dataItem.name isEqualToString:@"Parties"])
            {
      
            }
            break;
            
        case 1:
                 
            break;
            
        default:
            break;
    }
}


#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
           //NSLog(@"Cancelled");
            break;
        case MFMailComposeResultSaved:
           ///NSLog(@"Saved");
            break;
        case MFMailComposeResultSent:
           //NSLog(@"Sent");
            break;
        case MFMailComposeResultFailed:
           //NSLog(@"Failed");
            break;
        default:
           //NSLog(@"Not sent");
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            //NSLog(@"Cancelled");
            break;
        case MessageComposeResultSent:
            ///NSLog(@"Sent");
            break;
        case MessageComposeResultFailed :
            //NSLog(@"Failed");
            break;
        default:
            //NSLog(@"Not sent");
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Events

-(IBAction)tappedSendMail:(id)sender
{
    MFMailComposeViewController* mailComposeViewController = [[MFMailComposeViewController alloc] init];
   [mailComposeViewController setSubject:self.selectedBar.name];
   [mailComposeViewController setMessageBody:self.selectedBar.address isHTML:YES];
    mailComposeViewController.mailComposeDelegate = self;
    
   [self presentViewController:mailComposeViewController animated:YES completion:nil];
}

-(IBAction)tappedSendSMS:(id)sender
{
    MFMessageComposeViewController* messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    [messageComposeViewController setSubject:self.selectedBar.name];
    
    NSString* messageBody = [NSString stringWithFormat:@"%@ - %@", self.selectedBar.name, self.selectedBar.address];
    [messageComposeViewController setBody:messageBody];
    messageComposeViewController.messageComposeDelegate = self;
    
    [self presentViewController:messageComposeViewController animated:YES completion:nil];
}

#pragma mark - Navigation

 - (IBAction)unwindToBarDetails:(UIStoryboardSegue *)unwindSegue
 {
 
 }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass: [BarWebViewController class]])
    {
        BarWebViewController* barWebViewController = segue.destinationViewController;
        
        if ([segue.identifier isEqualToString: @"websiteSegue"])
        {
            barWebViewController.url = self.selectedBar.websiteUrl;
        }
        if ([segue.identifier isEqualToString: @"calendarSegue"])
        {
            barWebViewController.url = self.selectedBar.calendarUrl;
        }
        if ([segue.identifier isEqualToString: @"facebookSegue"])
        {
            barWebViewController.url = self.selectedBar.facebookUrl;
        }
        if ([segue.identifier isEqualToString: @"yelpSegue"])
        {
            barWebViewController.url = self.selectedBar.yelpUrl;
        }
    }
    
    if ([segue.destinationViewController isKindOfClass: [BarMapViewController class]])
    {
        BarMapViewController* barMapViewController = segue.destinationViewController;

        barMapViewController.selectedBar = self.selectedBar;
    }
}

@end
