//
//  BarDetailsViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailsViewController.h"

@interface BarDetailsViewController () 

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* dataDetail;
@property (readwrite, nonatomic, strong) NSMutableArray* dataFavorite;
@property (readwrite, nonatomic, strong) NSMutableArray* dataShare;

@end

@implementation BarDetailsViewController

static NSString* SAVEDBARSDICT = @"savedBarsDict";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initNavigation];
    
    [self initTableViewHeader];
    
    [self initTableViewFooter];
    
    NSMutableArray* barDetails = [self getBarDetails];
    [self loadTableViewData: barDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%@", NSStringFromClass ([self class]));
}
          
- (void)initNavigation {
    
    self.navigationItem.title = [self.selectedBar.name uppercaseString];
}

-(void)initTableViewHeader {
    
    NSArray* xib = [[NSBundle mainBundle] loadNibNamed:@"BarDetailHeaderViewCell" owner:nil options:nil];
    
    BarDetailHeaderViewCell* barDetailHeaderViewCell = [xib lastObject];
    
    barDetailHeaderViewCell.frame = CGRectMake(0, 0, 150, 150);
    
    if (self.selectedBar.icon != nil) {
        barDetailHeaderViewCell.logo.image = self.selectedBar.icon;
    }
    else {
        barDetailHeaderViewCell.logo.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    }
    self.tableView.tableHeaderView = barDetailHeaderViewCell;
}

-(void)initTableViewFooter {
    
    UIView* tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 10.0)];
    
    self.tableView.tableHeaderView = tableFooterView;
}

-(NSMutableArray*)getBarDetails{
    
    if (self.appDelegate.cachedBarDetails) {
        return self.appDelegate.cachedBarDetails;
    }
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"BarDetail" ofType:@"json"];
    
    NSData* jsonData = [NSData dataWithContentsOfFile:path];
    
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableArray* barDetails = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0) {
        for (int i = 0; i < arrayData.count; i++) {
            
            NSDictionary* dictTemp = arrayData[i];
            
            BarDetail* item = [BarDetail initFromDictionary: dictTemp];
            
            [barDetails addObject:item];
        }
    }
    
    self.appDelegate.cachedBarDetails = barDetails;
    
    return barDetails;
}

-(void)loadTableViewData: (NSMutableArray*)barDetails {
    
    self.dataDetail = [[NSMutableArray alloc] init];
    
    self.dataFavorite = [[NSMutableArray alloc] init];
    
    self.dataShare = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < barDetails.count; i++) {
        
        BarDetail* item = barDetails[i];
        
        if (item.section == 0 && item.statusFlag == 1) {
            [self.dataDetail addObject:item];
        }
        else if (item.section == 1 && item.statusFlag == 1) {
            [self.dataFavorite addObject:item];
        }
        else if (item.section == 2 && item.statusFlag == 1) {
            [self.dataShare addObject:item];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* sectionHeaderView = [[UIView alloc] init];
    
    sectionHeaderView.backgroundColor = [UIColor blackColor];
    
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, -30, tableView.bounds.size.width-10, 100)];
    
    [titleLabel setFont:[UIFont fontWithName: @"Helvetica Neue" size: 15.0f]];
   
    titleLabel.backgroundColor = [UIColor clearColor];
   
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
  
    titleLabel.numberOfLines = 0;
  
    titleLabel.textColor = [UIColor grayColor];
    
    [sectionHeaderView addSubview:titleLabel];
    
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
    
    return sectionHeaderView;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
   
    UIView* sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 50.0)];
    
    sectionFooterView.backgroundColor = [UIColor blackColor];
    
    return sectionFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch(section) {
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
    
    switch(section) {
        case 0:
            return 0.0f;
        case 1:
            return 0.0f;
        case 2:
            return 50.0f;
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
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

-(NSString*)getPropertyValueFromPropertyName:(NSString*)propertyName forSelectedBar:(Bar*)bar {
    
    if([propertyName isEqualToString: NSLocalizedString(@"Address", @"Address")]) {
        return bar.address;
    }
    else if ([propertyName isEqualToString: NSLocalizedString(@"Phone", @"Phone")]){
         return bar.phone;
    }
    else {
        return propertyName;
    }
}

-(void)setCellStyle:(UITableViewCell *)cell {
    
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    
    BarDetail* barDetail;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];

    switch(indexPath.section) {
        case 0:
            barDetail = self.dataDetail[rowIndex];
            break;
        case 1:
            barDetail = self.dataFavorite[rowIndex];
            break;
        case 2:
            barDetail = self.dataShare[rowIndex];
            break;
        default:
            break;
    }
    
    cell.textLabel.text =  [self getPropertyValueFromPropertyName: barDetail.name forSelectedBar:self.selectedBar];
    
    cell.imageView.image = [UIImage imageNamed: barDetail.imageUrl];
    
    if (cell.imageView.image == nil)
    {
        cell.imageView.image = [UIImage imageNamed:@"Icon-Search"];
    }
    
    [self setCellStyle:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    
    BarDetail* barDetail;
    
    UIStoryboard* storyboard;
    
    switch(indexPath.section) {
        case 0:
            
            barDetail = self.dataDetail[rowIndex];
            
            if ([barDetail.name isEqualToString: NSLocalizedString(@"Address", @"Address")]) {
                
                [self openMapsActionSheet: self];
            }
            else if ([barDetail.name isEqualToString: NSLocalizedString(@"Phone", @"Phone")]) {
                
               NSString* phoneNumber = [self.selectedBar.phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
                
               phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
                
               phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@"-"];
                
               NSURL* tel = [NSURL URLWithString:[NSString stringWithFormat:@"tel:1-%@", phoneNumber]];
                
                if ([[UIApplication sharedApplication] canOpenURL: tel]) {
                    
                    [[UIApplication sharedApplication] openURL: tel];
                }
                else {
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Info",@"Info")
                                                                        message: NSLocalizedString(@"Unable to dial phone number", @"Unable to dial phone number")
                                                                       delegate:nil
                                                              cancelButtonTitle: NSLocalizedString(@"OK",@"OK")
                                                              otherButtonTitles:nil];
                    
                    [alertView show];
                }
            }
            else if ([barDetail.name isEqualToString: NSLocalizedString(@"Website", @"Website")]) {
                
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                BarWebViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
                
                vc.url = self.selectedBar.websiteUrl;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([barDetail.name isEqualToString: NSLocalizedString(@"Events", @"Events")]) {
                
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                BarWebViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
                
                vc.url = self.selectedBar.calendarUrl;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([barDetail.name isEqualToString: NSLocalizedString(@"Facebook Page", @"Facebook Page")]) {
                
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                BarWebViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
                
                vc.url = self.selectedBar.facebookUrl;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([barDetail.name isEqualToString:NSLocalizedString(@"Yelp Reviews", @"Yelp Reviews")]) {
                
                storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                BarWebViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
                
                vc.url = self.selectedBar.yelpUrl;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            
        case 1:
             barDetail = self.dataFavorite[rowIndex];
            
            //TODO: refactor
            if ([barDetail.name isEqualToString: NSLocalizedString(@"Save", @"Save")]) {
              
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
               
                NSMutableDictionary* savedBarsDict = [[defaults dictionaryForKey:SAVEDBARSDICT] mutableCopy];
                
                if (savedBarsDict == nil) {
                    savedBarsDict = [[NSMutableDictionary alloc] init];
                }
                
                NSString* barIdAsString =  [NSString stringWithFormat:@"%d", (int)self.selectedBar.barId];
                
                NSObject* barId =  [savedBarsDict objectForKey:barIdAsString];
                
                if (barId == nil) {
                    [savedBarsDict setValue:barIdAsString forKey:barIdAsString];
               
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message: NSLocalizedString(@"Save", @"Save") delegate:nil cancelButtonTitle: NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
                    
                    [alertView show];
                    
                } else {
                    
                    [savedBarsDict removeObjectForKey:barIdAsString];
                    
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Unsaved", @"Unsaved") delegate:nil cancelButtonTitle: NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
                    
                    [alertView show];
                }
                
                [defaults setObject:savedBarsDict forKey:SAVEDBARSDICT];

            }
            break;
            
            case 2:
            
                barDetail = self.dataShare[rowIndex];
            
                if ([barDetail.name isEqualToString: NSLocalizedString(@"Message", @"Message")]) {
                    [self tappedSendSMS];
                }
                else if ([barDetail.name isEqualToString: NSLocalizedString(@"Email", @"Email")]) {
                    [self tappedSendMail];
                }
    
            break;
        default:
            break;
    }
}

-(void)openMapsActionSheet:(id)sender {
   
    UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle: NSLocalizedString(@"Open in Maps", @"Open in Maps")
                                                       delegate:self
                                              cancelButtonTitle: NSLocalizedString(@"Cancel", @"Cancel")
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"Apple Maps", @"Apple Maps"), NSLocalizedString(@"Google Maps", @"Google Maps"), nil];
    
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.selectedBar.latitude,self.selectedBar.longitude);
    
    if (buttonIndex == 0) {
       
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:location addressDictionary:nil];
        
        MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
        
        item.name = self.selectedBar.name;
        
        [item openInMapsWithLaunchOptions:nil];
        
    } else if (buttonIndex==1) {
        /*TODO: use call back scheme instead
         comgooglemaps-x-callback://?center=40.765819,-73.975866&zoom=14
         &x-success=sourceapp://?resume=true
         &x-source=SourceApp
         */
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?daddr=%f,%f",location.latitude,location.longitude]];
        if (![[UIApplication sharedApplication] canOpenURL:url]) {
          
            //TODO: launch maps.google.com in safari instead of giving this alert.
             UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Info", @"Info")
                                                                message: NSLocalizedString(@"Google Maps is not installed on your device.", @"Google Maps is not installed on your device.")
                                                                delegate:self
                                                       cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                                       otherButtonTitles:nil];
            
            [alertView show];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
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

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result) {
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

 - (IBAction)unwindToBarDetails:(UIStoryboardSegue *)unwindSegue {
   //
 }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   //
}

@end
