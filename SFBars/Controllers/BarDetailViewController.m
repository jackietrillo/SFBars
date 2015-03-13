//
//  BarDetailsViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailViewController.h"

@interface BarDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* barDetailsData;
@property (readwrite, nonatomic, strong) NSMutableArray* dataDetail;
@property (readwrite, nonatomic, strong) NSMutableArray* dataFavorite;
@property (readwrite, nonatomic, strong) NSMutableArray* dataShare;

@end

@implementation BarDetailViewController

typedef enum {
    DetailTableViewSection = 0,
    FavoriteTableViewSection = 1,
    ShareTableViewSection = 2,
} BarDetailTableViewSections;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initNavigation];
    [self initTableView];
    
    [self loadTableViewData:[self.barsManager getBarDetailItems]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //NSLog(@"%@", NSStringFromClass ([self class]));
}
          
- (void)initNavigation {
    
    self.navigationItem.title = [self.selectedBar.name uppercaseString];
}

-(void)initTableView {
    NSArray* barDetailHeaderViewCellXib = [[NSBundle mainBundle] loadNibNamed:@"BarDetailHeaderViewCell" owner:nil options:nil];
    
    BarDetailHeaderViewCell* tableHeaderView = [barDetailHeaderViewCellXib lastObject];
    tableHeaderView.frame = CGRectMake(0, 0, 150, 0);
    tableHeaderView.logo.image = self.selectedBar.icon ? self.selectedBar.icon : [UIImage imageNamed:@"DefaultImage-Bar"];
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.tableHeaderView.hidden = YES;
    
    UIView* tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 10.0)];
    self.tableView.tableFooterView = tableFooterView;
}

-(void)loadTableViewData: (NSArray*)barDetailItems {
    self.dataDetail = [[NSMutableArray alloc] init];
    self.dataFavorite = [[NSMutableArray alloc] init];
    self.dataShare = [[NSMutableArray alloc] init];
    
    BarDetailItem* barDetailItem;
    
    for (int i = 0; i < barDetailItems.count; i++) {
        
        barDetailItem = barDetailItems[i];
        
        if (barDetailItem.section == DetailTableViewSection && barDetailItem.statusFlag) {
            [self.dataDetail addObject:barDetailItem];
        }
        else if (barDetailItem.section == FavoriteTableViewSection && barDetailItem.statusFlag) {
            [self.dataFavorite addObject:barDetailItem];
        }
        else if (barDetailItem.section == ShareTableViewSection && barDetailItem.statusFlag) {
            [self.dataShare addObject:barDetailItem];
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
    
    BarDetailItem* barDetailItem;
    
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    switch(indexPath.section) {
        case DetailTableViewSection:
            barDetailItem = self.dataDetail[rowIndex];
            break;
        case FavoriteTableViewSection:
            barDetailItem = self.dataFavorite[rowIndex];
            break;
        case ShareTableViewSection:
            barDetailItem = self.dataShare[rowIndex];
            break;
        default:
            break;
    }
    
    tableViewCell.textLabel.text =  [self getBarPropertyValueFromBarPropertyName: barDetailItem.name forSelectedBar:self.selectedBar];
    
    tableViewCell.imageView.image = [UIImage imageNamed: barDetailItem.imageUrl];
    
    if (tableViewCell.imageView.image == nil) {
        tableViewCell.imageView.image = [UIImage imageNamed:@"Icon-Search"];
    }
    
    [self setTableViewCellStyle:tableViewCell];
    
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    
    BarDetailItem* barDetailItem;
    
    UIViewController* viewController;
    
    BarDetailActionViewControllerFactory* barDetailActionViewControllerFactory = [[BarDetailActionViewControllerFactory alloc] init];
    
    switch(indexPath.section) {
        case DetailTableViewSection:
            barDetailItem = self.dataDetail[rowIndex];
            
            if ([barDetailItem.name isEqualToString: NSLocalizedString(@"Address", @"Address")]) {
                [self openMapsActionSheet: self];
            }
            else if ([barDetailItem.name isEqualToString: NSLocalizedString(@"Phone", @"Phone")]) {
               
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
            else {
                
                BarDetailActionType barDetailActionType = [BarsEnumParser enumFromString: barDetailItem.name];
                viewController = [barDetailActionViewControllerFactory viewControllerForAction: barDetailActionType withBar: self.selectedBar];
                
                [self.navigationController pushViewController:viewController animated:YES];
            }
            
            break;
            
        case FavoriteTableViewSection:
             barDetailItem = self.dataFavorite[rowIndex];
          
            /*
            UIAlertView* alertView;
            
            alertView = [[UIAlertView alloc] initWithTitle:@"" message: NSLocalizedString(@"Saved", @"Saved") delegate:nil cancelButtonTitle: NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            
            alertView = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"Removed", @"Removed") delegate:nil cancelButtonTitle: NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
            
            [alertView show];
            */
            break;
            
        case ShareTableViewSection:
            barDetailItem = self.dataShare[rowIndex];
        
            BarDetailActionType barDetailActionType = [BarsEnumParser enumFromString: barDetailItem.name];
            viewController = [barDetailActionViewControllerFactory viewControllerForAction: barDetailActionType withBar: self.selectedBar];
        
            if ([viewController isKindOfClass: [MFMailComposeViewController class]]) {
                ((MFMailComposeViewController*)viewController).mailComposeDelegate = self;
                 [self presentViewController:viewController animated:YES completion:nil];
            }
            if ([viewController isKindOfClass: [MFMessageComposeViewController class]]) {
                ((MFMessageComposeViewController*)viewController).messageComposeDelegate = self;
                 [self presentViewController:viewController animated:YES completion:nil];
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

@end
