//
//  SearchTableViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/26/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "SearchViewController.h"


@interface SearchViewController ()

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchResultsViewController* searchResultsViewController;
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;
@property (nonatomic, strong) AppDelegate* appDelegate;

@end

@implementation SearchViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [self.appDelegate.barsFacade getBars: ^(NSArray* data) {
        self.bars = data;
        [self.tableView reloadData];
    }];
    
    [self initNavigation];
    [self initSearchViewController];
}

-(void)initSearchViewController {

    self.searchResultsViewController = [[SearchResultsViewController alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsViewController];
    self.searchController.searchResultsUpdater = self;
    
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.backgroundColor = [UIColor blackColor];

    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.tableView.frame = CGRectMake(0, 250, self.tableView.bounds.size.width, self.tableView.bounds.size.height);
    
    self.searchResultsViewController.tableView.delegate = self;
    self.searchResultsViewController.tableView.backgroundColor = [UIColor blackColor];
    self.searchResultsViewController.tableView.separatorColor = [UIColor yellowColor];
    
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.searchBar.delegate = self;
    
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
}

-(void)initNavigation {
     self.navigationItem.title = NSLocalizedString(@"SEARCH", @"SEARCH");
    
    // Hack to remove text in back button on segued view controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    Bar* bar = self.bars[indexPath.row];
   
    [self configureCell:cell forBar:bar];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Bar* selectedBar = (tableView == self.tableView) ? self.bars[indexPath.row] : self.searchResultsViewController.filteredBars[indexPath.row];
    
    BarDetailViewController* barDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BarDetailViewController"];
    barDetailViewController.selectedBar = selectedBar;
    
    [self.navigationController pushViewController:barDetailViewController animated:YES];
    
    // note iOS 8.0 bug
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // Hack to remove back button text on segued screen
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
   
    // TODO move this logic into a BarSearchManager
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [[NSMutableArray alloc] init];
    for (Bar *bar in self.bars ) {
        NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
        NSRange barNameRange = NSMakeRange(0, bar.name.length);
        NSRange foundRange = [bar.name rangeOfString:searchText options:searchOptions range:barNameRange];
        
        if (foundRange.length > 0) {
            [searchResults addObject:bar];
        }
    }
    
    // hand over the filtered results to our search results table
    SearchResultsViewController* searchResultsTableViewController = (SearchResultsViewController *)self.searchController.searchResultsController;
    searchResultsTableViewController.filteredBars = searchResults;
    [searchResultsTableViewController.tableView reloadData];
}


#pragma mark - UIStateRestoration

// we restore several items for state restoration:
//  1) Search controller's active state,
//  2) search text,
//  3) first responder

NSString *const ViewControllerTitleKey = @"ViewControllerTitleKey";
NSString *const SearchControllerIsActiveKey = @"SearchControllerIsActiveKey";
NSString *const SearchBarTextKey = @"SearchBarTextKey";
NSString *const SearchBarIsFirstResponderKey = @"SearchBarIsFirstResponderKey";

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    // encode the view state so it can be restored later
    
    // encode the title
    [coder encodeObject:self.title forKey:ViewControllerTitleKey];
    
    UISearchController *searchController = self.searchController;
    
    // encode the search controller's active state
    BOOL searchDisplayControllerIsActive = searchController.isActive;
    [coder encodeBool:searchDisplayControllerIsActive forKey:SearchControllerIsActiveKey];
    
    // encode the first responder status
    if (searchDisplayControllerIsActive) {
        [coder encodeBool:[searchController.searchBar isFirstResponder] forKey:SearchBarIsFirstResponderKey];
    }
    
    // encode the search bar text
    [coder encodeObject:searchController.searchBar.text forKey:SearchBarTextKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    // restore the title
    self.title = [coder decodeObjectForKey:ViewControllerTitleKey];
    
    // restore the active state:
    // we can't make the searchController active here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerWasActive = [coder decodeBoolForKey:SearchControllerIsActiveKey];
    
    // restore the first responder status:
    // we can't make the searchController first responder here since it's not part of the view
    // hierarchy yet, instead we do it in viewWillAppear
    //
    _searchControllerSearchFieldWasFirstResponder = [coder decodeBoolForKey:SearchBarIsFirstResponderKey];
    
    // restore the text in the search field
    self.searchController.searchBar.text = [coder decodeObjectForKey:SearchBarTextKey];
}

@end

