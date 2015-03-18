//
//  SettingsViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/25/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* settingsData;
@property (readwrite, nonatomic, strong) NSMutableArray* settingsDataTop;
@property (readwrite, nonatomic, strong) NSMutableArray* settingsDataBottom;

@end

typedef enum {
    SettingsTableViewSectionTop = 0,
    SettingsTableViewSectionBottom = 1,
} SettingsTableViewSection;

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavigation];
    
    [self loadTableViewData:[self.barsFacade getSettingsItems]];
}

-(void)initNavigation {
     self.navigationItem.title = NSLocalizedString(@"SETTINGS", @"SETTINGS");
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

-(void)loadTableViewData:(NSArray*)settingsItems {
    self.settingsDataTop = [[NSMutableArray alloc] init];
    self.settingsDataBottom = [[NSMutableArray alloc] init];
    
    SettingsItem* settingsItem;
    
    for (int i = 0; i < settingsItems.count; i++) {
        settingsItem = settingsItems[i];
       
        if (settingsItem.section == SettingsTableViewSectionTop && settingsItem.statusFlag == 1) {
            [self.settingsDataTop addObject:settingsItem];
        }
        else if (settingsItem.section == SettingsTableViewSectionBottom && settingsItem.statusFlag == 1) {
            [self.settingsDataBottom addObject:settingsItem];
        }
    }
}

-(void)setTableViewCellStyle:(UITableViewCell *)tableViewCell {
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.textLabel.highlightedTextColor = [UIColor blackColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
    
    switch(section) {
        case SettingsTableViewSectionTop:
            [sectionHeaderView setBackgroundColor:[UIColor blackColor]];
            break;
        case SettingsTableViewSectionBottom:
            [sectionHeaderView setBackgroundColor:[UIColor blackColor]];
            break;
        default:
            break;
    }
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case SettingsTableViewSectionTop:
            return @" ";
        case SettingsTableViewSectionBottom:
            return @" ";
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section) {
        case SettingsTableViewSectionTop:
            return [self.settingsDataTop count];
        case SettingsTableViewSectionBottom:
            return [self.settingsDataBottom count];
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    SettingsItem* settingsItem;
   
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    switch(indexPath.section) {
        case SettingsTableViewSectionTop:
            settingsItem = self.settingsDataTop[rowIndex];
            
            tableViewCell.textLabel.text = settingsItem.name;
            tableViewCell.imageView.image = [UIImage imageNamed:settingsItem.imageUrl];
            break;
        case SettingsTableViewSectionBottom:
            settingsItem = self.settingsDataBottom[rowIndex];
            
            tableViewCell.textLabel.text = settingsItem.name;
            tableViewCell.imageView.image = [UIImage imageNamed:settingsItem.imageUrl];
            break;
        default:
            break;
    }
    
    [self setTableViewCellStyle:tableViewCell];
    
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    SettingsItem* settingsItem;
    
    switch(indexPath.section)
    {
        case SettingsTableViewSectionTop:
            settingsItem = self.settingsDataTop[rowIndex];
            if ([settingsItem.name isEqualToString: NSLocalizedString(@"Rate App", @"Rate App")]) {
                [self tappedRateApp];
            }
            else if ([settingsItem.name isEqualToString: NSLocalizedString(@"Feedback",@"Feedback")]) {
                [self tappedSendFeedback];
            }
            else if ([settingsItem.name isEqualToString: NSLocalizedString(@"Report a Problem",@"Report a Problem")]) {
                [self tappedContactUs];
            }
            break;
            
        case SettingsTableViewSectionBottom:
            settingsItem = self.settingsDataBottom[rowIndex];
            
            if ([settingsItem.name isEqualToString: NSLocalizedString(@"Upgrade", @"Upgrade")]) {
                [self tappedUpgrade];
            }
                      break;
        default:
            break;
    }
}

-(void)tappedSendFeedback {
    MFMailComposeViewController* mailComposeViewController = [[MFMailComposeViewController alloc] init];
    [mailComposeViewController setSubject: NSLocalizedString(@"Feedback",@"Feedback")];
    [mailComposeViewController setToRecipients:@[@"jackietrillo@hotmail.com"]];
    mailComposeViewController.mailComposeDelegate = self;
    
    [self presentViewController:mailComposeViewController animated:YES completion:nil];
}

-(void)tappedContactUs {
    MFMailComposeViewController* mailComposeViewController = [[MFMailComposeViewController alloc] init];
    mailComposeViewController.mailComposeDelegate = self;
    [mailComposeViewController setSubject: NSLocalizedString(@"Report a Problem",@"Report a Problem")];
    [mailComposeViewController setToRecipients:@[@"jackietrillo@hotmail.com"]];

    [self presentViewController:mailComposeViewController animated:YES completion:nil];
}

-(void)tappedRateApp {
    NSString* link = @"itms-apps://itunes.apple.com/app/375031865";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
}

-(void)tappedUpgrade {
    NSString* link = @"itms-apps://itunes.apple.com/app/375031865";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:link]];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
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


@end
