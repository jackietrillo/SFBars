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
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataTop;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataBottom;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initNavigation];
    [self loadData];
}

-(void)initNavigation
{
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] init];
    
    [doneButton setTarget:self];
    [doneButton setAction:@selector(backToBrowse:)];
    
    UIFont* font = [UIFont fontWithName:@"fontawesome" size:30.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    [doneButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [doneButton setTitle:[NSString stringWithUTF8String:"\uf00c"]];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.title = NSLocalizedString(@"SETTINGS", @"SETTINGS");
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

-(void)loadData
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    [self parseData:data];
    data = nil;
}

-(void)parseData: (NSData*)jsonData {
    
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    self.menuDataTop = [[NSMutableArray alloc] init];
    self.menuDataBottom = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++)
        {
            NSDictionary* dictTemp = arrayData[i];
            MenuItem* menuItem = [MenuItem initFromDictionary: dictTemp];
            
            if (menuItem.section == 0 && menuItem.statusFlag == 1)
            {
                [self.menuDataTop addObject:menuItem];
            }
            else if (menuItem.section == 1 && menuItem.statusFlag == 1)
            {
                [self.menuDataBottom addObject:menuItem];
            }
        }
    }
}
-(void)setCellStyle:(UITableViewCell *)cell {
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
    
    switch(section)
    {
        case 0:
            [headerView setBackgroundColor:[UIColor blackColor]];
            break;
        case 1:
            [headerView setBackgroundColor:[UIColor blackColor]];
            break;
        default:
            break;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return @" ";
        case 1:
            return @" ";
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch(section) {
        case 0:
            return [self.menuDataTop count];
        case 1:
            return [self.menuDataBottom count];
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    MenuItem* menuItem;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    switch(indexPath.section) {
        case 0:
            menuItem = (MenuItem*)self.menuDataTop[rowIndex];
            cell.textLabel.text = menuItem.name;
            cell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];
            break;
        case 1:
            menuItem = (MenuItem*)self.menuDataBottom[rowIndex];
            cell.textLabel.text = menuItem.name;
            cell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];
            break;
        default:
            break;
    }
    
    [self setCellStyle:cell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    MenuItem* dataItem;
    
    switch(indexPath.section)
    {
        case 0:
            dataItem = (MenuItem*)self.menuDataTop[rowIndex];
            if ([dataItem.name isEqualToString: NSLocalizedString(@"Rate App", @"Rate App")]) {
                [self tappedRateApp];
            }
            else if ([dataItem.name isEqualToString: NSLocalizedString(@"Feedback",@"Feedback")]) {
                [self tappedSendFeedback];
            }
            else if ([dataItem.name isEqualToString: NSLocalizedString(@"Report a Problem",@"Report a Problem")]) {
                [self tappedContactUs];
            }
            break;
            
        case 1:
            dataItem = (MenuItem*)self.menuDataBottom[rowIndex];
            
            if ([dataItem.name isEqualToString: NSLocalizedString(@"Upgrade", @"Upgrade")]) {
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)backToBrowse: (id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
