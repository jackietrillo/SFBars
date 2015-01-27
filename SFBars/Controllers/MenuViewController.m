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
@property (readwrite, nonatomic, strong) NSMutableArray* menuData;

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
    self.menuData = [[NSMutableArray alloc] init];
    [self.menuData addObject:@"Browse"];
    [self.menuData addObject:@"Near Me"];
    [self.menuData addObject:@"Top List"];
    [self.menuData addObject:@"Parties"];
    [self initNavigation];
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
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.title = @"MENU";
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

-(void)setCellStyle:(UITableViewCell *)cell
{
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor blackColor];
    
    cell.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    cell.imageView.frame = CGRectMake(50,500,500,500);
    cell.indentationLevel = 0;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
  
    switch(section)
    {
        case 0:
             [headerView setBackgroundColor:[UIColor darkGrayColor]];
            break;
        case 1:
            [headerView setBackgroundColor:[UIColor darkGrayColor]];
            break;
        default:
            return 0;
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
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
            return [self.menuData count];
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
            cell.textLabel.text = self.menuData[rowIndex];
            break;
            
        case 1:
            cell.textLabel.text = @"My Favorites";
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
    [self performSegueWithIdentifier:@"unwindToBrowse" sender:self];
}

- (IBAction)unwindToMenu:(UIStoryboardSegue *)unwindSegue
{
    
}

@end
