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

typedef enum {
    DetailTableViewSection = 0,
    FavoriteTableViewSection = 1,
    ShareTableViewSection = 2,
} BarDetailTableViewSections;


- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initNavigation];
    [self initTableView];
    [self loadTableViewData: [self getBarDetails]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%@", NSStringFromClass ([self class]));
}
          
- (void)initNavigation {
    
    self.navigationItem.title = [self.selectedBar.name uppercaseString];
}

-(void)initTableView {
    
    NSArray* barDetailHeaderViewCellXib = [[NSBundle mainBundle] loadNibNamed:@"BarDetailHeaderViewCell" owner:nil options:nil];
    
    BarDetailHeaderViewCell* tableHeaderView = [barDetailHeaderViewCellXib lastObject];
    tableHeaderView.frame = CGRectMake(0, 0, 150, 150);
    tableHeaderView.logo.image = self.selectedBar.icon ? self.selectedBar.icon : [UIImage imageNamed:@"DefaultImage-Bar"];
    
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIView* tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 10.0)];
    self.tableView.tableFooterView = tableFooterView;
}

//TODO: refactor this out
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
    
    BarDetail* barDetail;
    
    for (int i = 0; i < barDetails.count; i++) {
        
        barDetail = barDetails[i];
        
        if (barDetail.section == DetailTableViewSection && barDetail.statusFlag) {
            [self.dataDetail addObject:barDetail];
        }
        else if (barDetail.section == FavoriteTableViewSection && barDetail.statusFlag) {
            [self.dataFavorite addObject:barDetail];
        }
        else if (barDetail.section == ShareTableViewSection && barDetail.statusFlag) {
            [self.dataShare addObject:barDetail];
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
    
    switch(section) {
        case DetailTableViewSection:
            titleLabel.text = self.selectedBar.descrip;
            break;
        case FavoriteTableViewSection:
            titleLabel.text = @"";
            break;
        case ShareTableViewSection:
            titleLabel.text = NSLocalizedString(@"Share", @"Share");
            break;
        default:
            break;;
    }
    
    [sectionHeaderView addSubview:titleLabel];
    
    return sectionHeaderView;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView* sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 50.0)];
    sectionFooterView.backgroundColor = [UIColor blackColor];
    return sectionFooterView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch(section) {
        case DetailTableViewSection:
            return 30;
        case FavoriteTableViewSection:
            return 10;
        case ShareTableViewSection:
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
        case DetailTableViewSection:
            return 0.0f;
        case FavoriteTableViewSection:
            return 0.0f;
        case ShareTableViewSection:
            return 50.0f;
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
        case DetailTableViewSection:
            return [self.dataDetail count];
        case FavoriteTableViewSection:
            return [self.dataFavorite count];
        case ShareTableViewSection:
            return [self.dataShare count];
        default:
            return 0;
    }
}

-(NSString*)getBarPropertyValueFromBarPropertyName:(NSString*)propertyName forSelectedBar:(Bar*)bar {
    
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

-(void)setTableViewCellStyle:(UITableViewCell *)tableViewCell {
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.textLabel.highlightedTextColor = [UIColor blackColor];
    tableViewCell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    
    BarDetail* barDetail;
    
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    switch(indexPath.section) {
        case DetailTableViewSection:
            barDetail = self.dataDetail[rowIndex];
            break;
        case FavoriteTableViewSection:
            barDetail = self.dataFavorite[rowIndex];
            break;
        case ShareTableViewSection:
            barDetail = self.dataShare[rowIndex];
            break;
        default:
            break;
    }
    
    tableViewCell.textLabel.text =  [self getBarPropertyValueFromBarPropertyName: barDetail.name forSelectedBar:self.selectedBar];
    
    tableViewCell.imageView.image = [UIImage imageNamed: barDetail.imageUrl];
    
    if (tableViewCell.imageView.image == nil) {
        tableViewCell.imageView.image = [UIImage imageNamed:@"Icon-Search"];
    }
    
    [self setTableViewCellStyle:tableViewCell];
    
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    BarDetail* barDetail;
    UIStoryboard* storyboard;
    
    // TODO: consider using factory pattern here?
    switch(indexPath.section) {
        case DetailTableViewSection:
            
            barDetail = self.dataDetail[rowIndex];
            
            if ([barDetail.name isEqualToString: NSLocalizedString(@"Address", @"Address")]) {
                [self openMapsActionSheet: self];
            }
            else if ([barDetail.name isEqualToString: NSLocalizedString(@"Phone", @"Phone")]) {
               
               NSString* phoneNumber = [self.selectedBar.phone stringByReplacingOccurrencesOfString:@"(" withString:@""];
               phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
               phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@"-"];
                
               NSURL* telephoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:1-%@", phoneNumber]];
                
                if ([[UIApplication sharedApplication] canOpenURL: telephoneURL]) {
                    
                    [[UIApplication sharedApplication] openURL: telephoneURL];
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
            
        case FavoriteTableViewSection:
             barDetail = self.dataFavorite[rowIndex];
            
            //TODO: this needs to be refactored 
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
            
            case ShareTableViewSection:
            
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
    
    if (buttonIndex == AppleMaps) {
       
        MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:location addressDictionary:nil];
    
        MKMapItem* mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        mapItem.name = self.selectedBar.name;
        [mapItem openInMapsWithLaunchOptions:nil];
        
    } else if (buttonIndex == GoogleMaps) {
        /*TODO: use s call back scheme instead
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
            [[UIApplication sharedApplication] openURL:url]; //launch Google Maps App
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
    [messageComposeViewController setBody:[NSString stringWithFormat:@"%@ - %@", self.selectedBar.name, self.selectedBar.address]];
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
