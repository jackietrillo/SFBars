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
@property (readwrite, nonatomic, strong) NSMutableArray* menuItems;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataTop;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataMiddle;
@property (readwrite, nonatomic, strong) NSMutableArray* menuDataBottom;
@end

@implementation MenuViewController

typedef enum {
    MenuTableViewSectionTop = 0,
    MenuTableViewSectionMiddle = 1,
    MenuTableViewSectionBottom = 2,
} MenuTableViewSection;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    [self initTableView];
    
    [self loadTableViewData:[self.barsFacade getMainMenuItems]];
}

-(void)initNavigation {
    self.navigationItem.title = NSLocalizedString(@"MENU", @"MENU");
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    // hack remove the "Back" text from segued controller's back bar button item
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)initTableView {
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MenuBackground"]];
}

-(void)loadTableViewData: (NSArray*)menuItems {
    self.menuDataTop = [[NSMutableArray alloc] init];
    self.menuDataMiddle = [[NSMutableArray alloc] init];
    self.menuDataBottom = [[NSMutableArray alloc] init];
    
    MenuItem* menuItem;
    
    for (int i = 0; i < menuItems.count; i++) {
        menuItem = menuItems[i];
        
        if (menuItem.section == MenuTableViewSectionTop && menuItem.statusFlag == 1) {
            [self.menuDataTop addObject:menuItem];
        }
        else if (menuItem.section == MenuTableViewSectionMiddle && menuItem.statusFlag == 1) {
            [self.menuDataMiddle addObject:menuItem];
        }
        else if (menuItem.section == MenuTableViewSectionBottom && menuItem.statusFlag == 1) {
            [self.menuDataBottom addObject:menuItem];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 100)];
  
    switch(section) {
        case MenuTableViewSectionTop:
             [headerView setBackgroundColor:[UIColor clearColor]];
            break;
        case MenuTableViewSectionMiddle:
            [headerView setBackgroundColor:[UIColor clearColor]];
            break;
        case MenuTableViewSectionBottom:
            [headerView setBackgroundColor:[UIColor clearColor]];
            break;
        default:
             break;;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch(section) {
        case MenuTableViewSectionTop:
            return 50;
        case MenuTableViewSectionMiddle:
            return 20;
        case MenuTableViewSectionBottom:
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
        case MenuTableViewSectionTop:
            return @" ";
        case MenuTableViewSectionMiddle:
            return @" ";
        case MenuTableViewSectionBottom:
            return @" ";
        default:
            return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section) {
        case MenuTableViewSectionTop:
            return [self.menuDataTop count];
        case MenuTableViewSectionMiddle:
            return [self.menuDataMiddle count];
        case MenuTableViewSectionBottom:
            return [self.menuDataBottom count];
        default:
            return 0;
    }
}

-(void)setTableViewCellStyle:(UITableViewCell *)tableViewCell {
    [tableViewCell.textLabel setTextColor:[UIColor whiteColor]];
    tableViewCell.textLabel.highlightedTextColor = [UIColor grayColor];
    tableViewCell.accessoryType =  UITableViewCellAccessoryNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    UIView* separatorLineTop = [[UIView alloc] initWithFrame:CGRectMake(42, 0, cell.bounds.size.width, 0.5)];
    separatorLineTop.backgroundColor = [UIColor yellowColor];
    [cell.selectedBackgroundView addSubview:separatorLineTop];
    
    UIView* separatorLineBottom = [[UIView alloc] initWithFrame:CGRectMake(42, cell.bounds.size.height - 1, cell.bounds.size.width , 0.5)];
    separatorLineBottom.backgroundColor = [UIColor yellowColor];
    [cell.selectedBackgroundView addSubview:separatorLineBottom];
    
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;

    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    MenuItem* menuItem;
    switch(indexPath.section) {
        case MenuTableViewSectionTop:
            menuItem = (MenuItem*)self.menuDataTop[rowIndex];
            
            tableViewCell.textLabel.text = menuItem.name;
            tableViewCell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];
            break;
        case MenuTableViewSectionMiddle:
            menuItem = (MenuItem*)self.menuDataMiddle[rowIndex];
            
            tableViewCell.textLabel.text = menuItem.name;
            tableViewCell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];
            break;
        case MenuTableViewSectionBottom:
            menuItem = (MenuItem*)self.menuDataBottom[rowIndex];
        
            tableViewCell.textLabel.text = menuItem.name;
            tableViewCell.imageView.image = [UIImage imageNamed:menuItem.imageUrl];
            break;
        default:
            break;
    }
    [self setTableViewCellStyle:tableViewCell];
    
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* navigationController = self.menuContainerViewController.centerViewController;
    UIViewController* viewController;
    
    MenuItem* menuItem;

    switch(indexPath.section) {
        case MenuTableViewSectionTop:
            menuItem = (MenuItem*)self.menuDataTop[rowIndex];
            
            viewController = [storyboard instantiateViewControllerWithIdentifier:menuItem.controller];
            [navigationController pushViewController:viewController animated:YES];
            
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            break;
            
        case MenuTableViewSectionMiddle:
            menuItem = (MenuItem*)self.menuDataMiddle[rowIndex];
            if ([menuItem.name isEqualToString: NSLocalizedString(@"Favorites", @"Favorites")]) {
               
                NSArray* favoriteBars = [self.barsFacade getFavorites];
                if (favoriteBars) {
                    BarViewController* barViewController = [storyboard instantiateViewControllerWithIdentifier:@"BarViewController"];
                    barViewController.filterBy = BarsFilterByBars;
                    barViewController.filterIds = favoriteBars;
                    [navigationController pushViewController:barViewController animated:YES];
                    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
                }
                else {
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Info", @"Info")
                                                                        message: NSLocalizedString(@"You have no favorites.", @"You have no favorites.")
                                                                       delegate: nil
                                                              cancelButtonTitle: NSLocalizedString(@"Cancel", @"Cancel")
                                                              otherButtonTitles: nil];
                    [alertView show];
                }
            }
            break;
            
        case MenuTableViewSectionBottom:
            menuItem = (MenuItem*)self.menuDataBottom[rowIndex];
            if ([menuItem.name isEqualToString: NSLocalizedString(@"Settings", @"Settings")]) {
                viewController = [storyboard instantiateViewControllerWithIdentifier:menuItem.controller];
                [navigationController pushViewController:viewController animated:YES];
                [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
            }
            break;
        
        default:
            break;
    }
}

@end
