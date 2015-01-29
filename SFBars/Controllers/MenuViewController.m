//
//  MenuViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/25/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataTop;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataBottom;
@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initController];
}

-(void)initController
{
    [self initNavigation];
    
    [self loadData];
}

-(void)loadData
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"json"];
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
            
            if (menuItem.section == 0)
            {
                [self.menuDataTop addObject:menuItem];
            }
            else if (menuItem.section == 1)
            {
                [self.menuDataBottom addObject:menuItem];
            }
        }
    }
}

-(void)initNavigation
{
    self.navigationItem.title = @"SF BARS"; //TODO localize
    [self.navigationItem setHidesBackButton:YES animated:YES];
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
             break;;
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
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

-(void)setCellStyle:(UITableViewCell *)cell
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowIndex = indexPath.row;
    MenuItem* menuItem;
    
    switch(indexPath.section)
    {
        case 0:
            menuItem = (MenuItem*)self.menuDataTop[rowIndex];
            
            if ([menuItem.name isEqualToString:@"Browse"])
            {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                BrowseViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BrowseViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([menuItem.name isEqualToString:@"Near Me"])
            {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NearMeViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"NearMeViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            
        case 1:
            menuItem = (MenuItem*)self.menuDataBottom[rowIndex];
            
            if ([menuItem.name isEqualToString:@"Settings"])
            {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SettingsViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            break;
            
        default:
            break;
    }
}

 #pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

- (void)backToBrowse: (id)sender
{
    [self performSegueWithIdentifier:@"unwindToBrowse" sender:self];
}

- (IBAction)unwindToMenu:(UIStoryboardSegue *)unwindSegue
{
    
}

@end
