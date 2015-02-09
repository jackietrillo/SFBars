//
//  MenuViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/25/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataTop;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataMiddle;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataBottom;
@end

@implementation MenuViewController

static NSString* SAVEDBARSDICT = @"savedBarsDict"; //TODO: centralize

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initController];
}

-(void)initController {
    
    [self initNavigation];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MenuBackground"]];
    
    [self loadData];
}

-(void)initNavigation {
    
    self.navigationItem.title = @"SF BARS"; //TODO localize
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)loadData {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    [self parseData2:data];
}

-(void)parseData2: (NSData*)jsonData {
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
       //TODO: log error
       //TODO: alert User
    }
    
    self.menuDataTop = [[NSMutableArray alloc] init];
    self.menuDataMiddle = [[NSMutableArray alloc] init];
    self.menuDataBottom = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0) {
        
        for (int i = 0; i < arrayData.count; i++) {
            
            NSDictionary* dictTemp = arrayData[i];
            MenuItem* menuItem = [MenuItem initFromDictionary: dictTemp];
            
            if (menuItem.section == 0 && menuItem.statusFlag == 1)
            {
                [self.menuDataTop addObject:menuItem];
            }
            else if (menuItem.section == 1 && menuItem.statusFlag == 1)
            {
                [self.menuDataMiddle addObject:menuItem];
            }
            else if (menuItem.section == 2 && menuItem.statusFlag == 1)
            {
                [self.menuDataBottom addObject:menuItem];
            }
        }
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
  
    switch(section) {
        case 0:
             [headerView setBackgroundColor:[UIColor clearColor]];
            break;
        case 1:
            [headerView setBackgroundColor:[UIColor clearColor]];
            break;
        case 2:
            [headerView setBackgroundColor:[UIColor clearColor]];
            break;
        default:
             break;;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    switch(section) {
        case 0:
            return 50;
        case 1:
            return 20;
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
    
    return 0.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch(section) {
        case 0:
            return @" ";
        case 1:
            return @" ";
        case 2:
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
            return [self.menuDataMiddle count];
        case 2:
            return [self.menuDataBottom count];

        default:
            return 0;
    }
}

-(void)setCellStyle:(UITableViewCell *)cell {
   
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.textLabel.highlightedTextColor = [UIColor grayColor];
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator; //default chevron indicator
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    //Hack because seperator disappear when cell is selected
    UIView* separatorLineTop = [[UIView alloc] initWithFrame:CGRectMake(42, 0, cell.bounds.size.width, 0.5)];
    separatorLineTop.backgroundColor = [UIColor yellowColor];
    [cell.selectedBackgroundView addSubview:separatorLineTop];
    
    UIView* separatorLineBotton = [[UIView alloc] initWithFrame:CGRectMake(42, cell.bounds.size.height - 1, cell.bounds.size.width , 0.5)];
    separatorLineBotton.backgroundColor = [UIColor yellowColor];
    [cell.selectedBackgroundView addSubview:separatorLineBotton];
    
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowIndex = indexPath.row;
    MenuItem* menuItem;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    switch(indexPath.section) {
            
        case 0:
            menuItem = (MenuItem*)self.menuDataTop[rowIndex];
            cell.textLabel.text = menuItem.name;
            cell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];
            break;
        case 1:
            menuItem = (MenuItem*)self.menuDataMiddle[rowIndex];
            cell.textLabel.text = menuItem.name;
            cell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];
            break;
        case 2:
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
    MenuItem* menuItem;
    
    switch(indexPath.section) {
            
        case 0:
            menuItem = (MenuItem*)self.menuDataTop[rowIndex];
            
            if ([menuItem.name isEqualToString:@"Search"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                SearchViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            if ([menuItem.name isEqualToString:@"Browse"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                BrowseViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BrowseViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([menuItem.name isEqualToString:@"Near Me"]) {
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NearMeViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"NearMeViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([menuItem.name isEqualToString:@"Top List"]){
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                TopListViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"TopListViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else if ([menuItem.name isEqualToString:@"Music"]){
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                MusicViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"MusicViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }

            else if ([menuItem.name isEqualToString:@"Parties"]){
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                PartiesViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"PartiesViewController"];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            
        case 1:
            menuItem = (MenuItem*)self.menuDataMiddle[rowIndex];
            
            if ([menuItem.name isEqualToString:@"Saved"]) {
               
                //load up saved bars from NSUserDefaults
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSMutableDictionary* savedBarsDict = [defaults objectForKey:SAVEDBARSDICT];
             
                if (savedBarsDict != nil && savedBarsDict.count == 110) {
                    NSMutableArray* savedBars = [[NSMutableArray alloc] init];
               
                    for (id key in savedBarsDict) {
                        NSObject* barId = [savedBarsDict objectForKey:key];
                        if (barId != 0) {
                            [savedBars addObject:barId];
                        }
                    }
                    
                    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    BarViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"BarViewController"];
                    vc.bars = savedBars;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else {
                    //TODO: localize
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"You have no saved Bars." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                    [alertView show];
                }
            }
            
            break;
        case 2:
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

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (void)backToBrowse: (id)sender {
    [self performSegueWithIdentifier:@"unwindToBrowse" sender:self];
}

- (IBAction)unwindToMenu:(UIStoryboardSegue *)unwindSegue {
    
}

@end
