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
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataTop;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataBottom;

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

-(void)loadData
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"json"];
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
-(void)setCellStyle:(UITableViewCell *)cell
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
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
            return [self.menuDataTop count];
        case 1:
            return [self.menuDataBottom count];
        default:
            return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowIndex = indexPath.row;
    MenuItem* menuItem;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch(indexPath.section)
    {
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)backToBrowse: (id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
