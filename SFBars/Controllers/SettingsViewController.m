//
//  SettingsViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/25/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* settingsData;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initController];
}

-(void)initController
{
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
    self.navigationItem.title = @"SETTINGS";
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

- (void)loadData
{
    self.settingsData = [[NSMutableArray alloc] init];
    [self.settingsData addObject:@"Rate App"];
    [self.settingsData addObject:@"Feedback"];
    [self.settingsData addObject:@"Contact Us"];
}

-(void)setCellStyle:(UITableViewCell *)cell
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    cell.imageView.frame = CGRectMake(50,500,500,500);
    cell.indentationLevel = 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return @" ";
        case 1:
            return @" ";
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch(section)
    {
        case 0:
            return [self.settingsData count];
        case 1:
            return 1;
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowIndex = indexPath.row;
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch(indexPath.section)
    {
        case 0:
            cell.textLabel.text = self.settingsData[rowIndex];
            break;
            
        case 1:
            cell.textLabel.text = @"Upgrade";
            break;
            
        default:
            break;
    }
    [self setCellStyle:cell];
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)backToBrowse: (id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
