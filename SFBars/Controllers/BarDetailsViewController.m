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

static NSString* SAVEDBARSDICT = @"savedBarsDict"; //TODO: localize

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initController];
}

-(void)initController {
    
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

- (void)initNavigation {
    
    self.navigationItem.title = [self.selectedBar.name uppercaseString];
}

-(void)loadData {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"BarDetail" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    [self parseData:data];
}

-(void)parseData: (NSData*)jsonData {
    
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor blackColor];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -30, tableView.bounds.size.width-10, 100)];
    [titleLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 15.0f]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor grayColor];
    
    [headerView addSubview:titleLabel];
    
    switch(section) {
            
        case 0:
            titleLabel.text = self.selectedBar.descrip;
            break;
        case 1:
            titleLabel.text = @"";
            break;
        case 2:
            titleLabel.text = @"Share";
            break;
        default:
            break;;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch(section)
    {
        case 0:
            return 30;
        case 1:
            return 10;
        case 2:
            return 20;
        default:
            return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    switch(section)
    {
        case 0:
            return 0.0f;
        case 1:
            return 0.0f;
        case 2:
            return 100.0f;
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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

-(NSString*)getPropertyValue:(NSString*)propertyName forSelectedBar:(Bar*)bar {
    
    if([propertyName isEqualToString:@"Address"]) {
        return bar.address;
    }
    else if ([propertyName isEqualToString:@"Phone"]){
         return bar.phone;
    }
    else {
        return propertyName;
    }
}

-(void)setCellStyle:(UITableViewCell *)cell {
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    BarDetailItem* dataItem;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    switch(indexPath.section) {
        case 0:
            dataItem = (BarDetailItem*)self.dataDetail[rowIndex];
            break;
        case 1:
            dataItem = (BarDetailItem*)self.dataFavorite[rowIndex];
            break;
        case 2:
            dataItem = (BarDetailItem*)self.dataShare[rowIndex];
            break;
        default:
            break;
    }
    
    cell.textLabel.text =  [self getPropertyValue: dataItem.name forSelectedBar:self.selectedBar];
    cell.imageView.image = [UIImage imageNamed:dataItem.imageUrl];
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
            if ([dataItem.name isEqualToString:@"Address"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                BarMapViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarMapViewController"];
                vc.selectedBar = self.selectedBar;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([dataItem.name isEqualToString:@"Phone"]) {
               NSString* phoneNumber = [self.selectedBar.phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
               phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
               phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@"-"];
               NSURL* tel = [NSURL URLWithString:[NSString stringWithFormat:@"tel:1-%@", phoneNumber]];
                if ([[UIApplication sharedApplication] canOpenURL: tel]) {
                    [[UIApplication sharedApplication] openURL: tel];
                }
                else {
                    //TODO: how do we log this error?
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Unable to dial phone number" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertView show];
                }
            }
            else if ([dataItem.name isEqualToString:@"Website"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                BarWebViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
                vc.url = self.selectedBar.websiteUrl;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([dataItem.name isEqualToString:@"Events"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                BarWebViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
                vc.url = self.selectedBar.calendarUrl;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([dataItem.name isEqualToString:@"Facebook Page"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                BarWebViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
                vc.url = self.selectedBar.facebookUrl;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([dataItem.name isEqualToString:@"Yelp Reviews"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                BarWebViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
                vc.url = self.selectedBar.yelpUrl;
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            
        case 1:
             dataItem = (BarDetailItem*)self.dataFavorite[rowIndex];
            if ([dataItem.name isEqualToString:@"Save"]) {
              
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
               
                NSMutableDictionary* savedBarsDict = [[defaults dictionaryForKey:SAVEDBARSDICT] mutableCopy];
                if (savedBarsDict == nil) {
                    savedBarsDict = [[NSMutableDictionary alloc] init];
                }
                
                NSObject* barId =  [savedBarsDict objectForKey:self.selectedBar.barId];
                if (barId == nil) {
                    [savedBarsDict setValue:self.selectedBar.barId forKey:[self.selectedBar.barId stringValue]];
               
                    //TODO: localize
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    
                } else {
                    
                    [savedBarsDict removeObjectForKey:self.selectedBar.barId];
                    
                    //TODO: localize
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Unsaved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                }
                
                [defaults setObject:savedBarsDict forKey:SAVEDBARSDICT];

            }
            break;
            case 2:
                dataItem = (BarDetailItem*)self.dataShare[rowIndex];
                if ([dataItem.name isEqualToString:@"Message"]) {
                    [self tappedSendSMS];
                }
                else if ([dataItem.name isEqualToString:@"Email"]) {
                    [self tappedSendMail];
                }
            break;
        default:
            break;
    }
}


#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
            break;
        default:
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
            break;
        case MessageComposeResultSent:
            break;
        case MessageComposeResultFailed:
            break;
        default:
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Events

-(void)tappedSendMail {
    
    MFMailComposeViewController* mailComposeViewController = [[MFMailComposeViewController alloc] init];
   [mailComposeViewController setSubject:self.selectedBar.name];
   [mailComposeViewController setMessageBody:self.selectedBar.address isHTML:YES];
    mailComposeViewController.mailComposeDelegate = self;
    
   [self presentViewController:mailComposeViewController animated:YES completion:nil];
}

-(void)tappedSendSMS {
    
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
   //
 }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   //
}

@end
