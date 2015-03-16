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
@property (readwrite, nonatomic, strong) NSMutableArray* dataDetailSection;
@property (readwrite, nonatomic, strong) NSMutableArray* dataFavoriteSection;
@property (readwrite, nonatomic, strong) NSMutableArray* dataShareSection;

@property (readwrite, nonatomic, strong) BarDetailActionViewControllerFactory* barDetailActionViewControllerFactory;
@end

@implementation BarDetailViewController

typedef enum {
    DetailTableViewSection = 0,
    FavoriteTableViewSection = 1,
    ShareTableViewSection = 2,
} BarDetailTableViewSections;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.barDetailActionViewControllerFactory = [[BarDetailActionViewControllerFactory alloc] init];
    
    [self initNavigation];
    [self initTableView];
   
    [self loadTableViewData:[self.barsFacade getBarDetailItems]];
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
    self.dataDetailSection = [[NSMutableArray alloc] init];
    self.dataFavoriteSection = [[NSMutableArray alloc] init];
    self.dataShareSection = [[NSMutableArray alloc] init];
    
    BarDetailItem* barDetailItem;
    
    for (int i = 0; i < barDetailItems.count; i++) {
        
        barDetailItem = barDetailItems[i];
        
        if (barDetailItem.section == DetailTableViewSection && barDetailItem.statusFlag) {
            [self.dataDetailSection addObject:barDetailItem];
        }
        else if (barDetailItem.section == FavoriteTableViewSection && barDetailItem.statusFlag) {
            [self.dataFavoriteSection addObject:barDetailItem];
        }
        else if (barDetailItem.section == ShareTableViewSection && barDetailItem.statusFlag) {
            [self.dataShareSection addObject:barDetailItem];
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
            return [self.dataDetailSection count];
        case FavoriteTableViewSection:
            return [self.dataFavoriteSection count];
        case ShareTableViewSection:
            return [self.dataShareSection count];
        default:
            return 0;
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
            barDetailItem = self.dataDetailSection[rowIndex];
            break;
        case FavoriteTableViewSection:
            barDetailItem = self.dataFavoriteSection[rowIndex];
            break;
        case ShareTableViewSection:
            barDetailItem = self.dataShareSection[rowIndex];
            break;
        default:
            break;
    }
    
    tableViewCell.textLabel.text = [Bar getPropertyValueFromPropertyName: barDetailItem.name forBar:self.selectedBar];
    
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
    UIAlertView* alertView;

    switch(indexPath.section) {
            
        case DetailTableViewSection:
            barDetailItem = self.dataDetailSection[rowIndex];
            
            if ([barDetailItem.name isEqualToString: NSLocalizedString(@"Address", @"Address")]) {
                [self openMapsActionSheet: self];
            }
            else if ([barDetailItem.name isEqualToString: NSLocalizedString(@"Phone", @"Phone")]) {
                NSURL* telephoneURL = [TelephoneHelper telephoneUrl:self.selectedBar.phone];
                if ([[UIApplication sharedApplication] canOpenURL: telephoneURL]) {
                    [[UIApplication sharedApplication] openURL: telephoneURL];
                }
                else {
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Info",@"Info") message: NSLocalizedString(@"Unable to dial phone number", @"Unable to dial phone number") delegate:nil cancelButtonTitle: NSLocalizedString(@"OK",@"OK") otherButtonTitles:nil];
                    
                    [alertView show];
                   }
                }
            else {
                BarDetailActionType barDetailActionType = [BarsEnumParser barDetailActionTypeEnumFromString: barDetailItem.name];
                viewController = [self.barDetailActionViewControllerFactory viewControllerForAction: barDetailActionType withBar: self.selectedBar];
                
                [self.navigationController pushViewController:viewController animated:YES];
            }
            break;
            
        case FavoriteTableViewSection:
             barDetailItem = self.dataFavoriteSection[rowIndex];
            
             if (![self.barsFacade favoriteExits: self.selectedBar.barId]) {
                [self.barsFacade saveFavorite:self.selectedBar.barId];
                 
                 alertView = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Favorites", @"Favorites") message: NSLocalizedString(@"Favorite Added", @"Favorite Added") delegate:nil cancelButtonTitle: NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
             } else {
             
                 [self.barsFacade removeFavorite:self.selectedBar.barId];
                 alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Favorites", @"Favorites") message:NSLocalizedString(@"Favorite Removed", @"Favorite Removed") delegate:nil cancelButtonTitle: NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
             }
            
             [alertView show];
             break;
            
        case ShareTableViewSection:
            barDetailItem = self.dataShareSection[rowIndex];
        
            BarDetailActionType barDetailActionType = [BarsEnumParser barDetailActionTypeEnumFromString: barDetailItem.name];
           
            viewController = [self.barDetailActionViewControllerFactory viewControllerForAction: barDetailActionType withBar: self.selectedBar];
        
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
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle: NSLocalizedString(@"Open in Maps", @"Open in Maps")
                                                       delegate:self
                                              cancelButtonTitle: NSLocalizedString(@"Cancel", @"Cancel")
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:NSLocalizedString(@"Apple Maps", @"Apple Maps"), NSLocalizedString(@"Google Maps", @"Google Maps"), nil];
    
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.selectedBar.latitude,self.selectedBar.longitude);
    if (buttonIndex == AppleMaps) {
        MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:location addressDictionary:nil];
        MKMapItem* mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        mapItem.name = self.selectedBar.name;
        [mapItem openInMapsWithLaunchOptions:nil];
        
    } else if (buttonIndex == GoogleMaps) {
        /* TODO: use a call back scheme here so user can come back to this app
         comgooglemaps-x-callback://?center=40.765819,-73.975866&zoom=14
         &x-success=sourceapp://?resume=true
         &x-source=SourceApp
         */
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?daddr=%f,%f",location.latitude,location.longitude]];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            
            //TODO: if google maps is not installed launch maps.google.com in safari instead of giving this alert.
             UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Info", @"Info")
                                                                message: NSLocalizedString(@"Google Maps is not installed on your device.", @"Google Maps is not installed on your device.")
                                                                delegate:self
                                                       cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                                       otherButtonTitles:nil];
            
            [alertView show];
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
