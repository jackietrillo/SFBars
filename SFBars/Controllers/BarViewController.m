//
//  StreetBarsViewController.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BarViewController.h"

@interface BarViewController () 

@property (readwrite, nonatomic, strong) NSMutableArray* data;
@property (nonatomic, nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@property (readwrite, nonatomic, strong) LoadingView* loadingView;

@end

@implementation BarViewController

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bar/";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canDisplayBannerAds = YES;
    self.tableView.hidden = YES;
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    
    [self initNavigation];

    if (!self.appDelegate.cachedBars) {
        
        NSArray* xib = [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:nil options:nil];
        
        self.loadingView = [xib lastObject];
        
        self.loadingView.frame = self.view.bounds;
        
        [self.view addSubview:self.loadingView];
        
        [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    }
    else {
        [self loadData:self.appDelegate.cachedBars];
    }
}

- (void)dealloc {
    [self terminateImageDownloads];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [self terminateImageDownloads];
}

-(void)initNavigation {
    
    self.navigationItem.title = [self.titleText uppercaseString];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(NSMutableArray*)parseData: (NSData*)responseData {

    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];

    NSMutableArray* bars = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0) {
        for (int i = 0; i < arrayData.count; i++) {
            NSDictionary* dictTemp = arrayData[i];
            Bar* bar = [Bar initFromDictionary:dictTemp];
            [bars addObject:bar];
        }
    }
    
    return bars;
}

-(void)loadData: (NSMutableArray*) data {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
    if (!data) {
        return;
    }
    
    if (!self.appDelegate.cachedBars) {
        self.appDelegate.cachedBars = data;
    }
    
    if (self.filterType != FilterByNotAssigned && self.filterIds != nil) {
        self.data = [self filterData:data];
    }
    else {
        self.data = data;
    }
    
    [self.tableView reloadData];
    self.tableView.hidden = NO;
    if (self.loadingView) {
        self.loadingView.hidden = YES;
    }
}

-(NSMutableArray*)filterData: (NSMutableArray*) data {
    
    NSMutableArray* filteredData = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < data.count; i++) {
        Bar* bar = (Bar*)data[i];
        
        switch (self.filterType) {
            case FilterByBarTypes:
                for (int i = 0; i < self.filterIds.count; i++) {
                    if ([bar.barTypes containsObject: self.filterIds[i]] ) {
                        [filteredData addObject:bar];
                    }
                }
                break;
            case FilterByDistricts:
                if ([self.filterIds containsObject: [[NSNumber numberWithInteger:bar.districtId] stringValue]]) {
                    [filteredData addObject:bar];
                }
                break;
            case FilterByMusicTypes:
                if ([self.filterIds containsObject: [[NSNumber numberWithInteger:bar.musicTypeId] stringValue]]) {
                    [filteredData addObject:bar];
                }
                break;
            case FilterByBarIds:
                if ([self.filterIds containsObject: [[NSNumber numberWithInteger:bar.barId] stringValue]]) {
                    [filteredData addObject:bar];
                }
                break;
            default:
                break;
        }
        
    }
    return filteredData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    Bar* bar = self.data[rowIndex];
    
    BarTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    cell.nameLabel.text = bar.name;
    cell.descripLabel.text = bar.descrip;
    cell.addressLabel.text = bar.address;
    cell.hoursLabel.text = bar.hours;
    cell.websiteButton.tag = indexPath.row;
    cell.mapButton.tag = indexPath.row;
    
    if (!bar.icon) {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        {
            [self startImageDownload:bar forIndexPath:indexPath];
        }
        // if a download is deferred or in progress, return a placeholder image
        cell.logo.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    }
    else {
        cell.logo.image = bar.icon;
    }

    return cell;
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = color;
    [cell setSelectedBackgroundView:bgColorView];
}

#pragma mark - Table cell image download support

- (void)terminateImageDownloads {
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    self.tableView.hidden = YES;
    [self.imageDownloadsInProgress removeAllObjects];
}

- (void)startImageDownload:(Bar*)bar forIndexPath:(NSIndexPath *)indexPath {
    
    ImageDownloader *imageDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (imageDownloader == nil) {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.Entity = bar;
    
        [imageDownloader setCompletionHandler:^{
            
            BarTableViewCell* cell = (BarTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
            if (bar.icon != nil) {
                cell.logo.image = bar.icon;
            }
            else {
                cell.logo.image = [UIImage imageNamed:@"DefaultImage-Bar"];
            }
            
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
      
        (self.imageDownloadsInProgress)[indexPath] = imageDownloader;
        [imageDownloader startDownload];
    }
}

- (void)loadImagesForOnscreenRows {
    if (self.data.count > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            Bar* bar = (self.data)[indexPath.row];
            
            if (!bar.icon)  // Avoid the download if there is already an icon
            {
                [self startImageDownload:bar forIndexPath:indexPath];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadImagesForOnscreenRows];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass: [BarDetailsViewController class]]) {
        BarDetailsViewController* barDetailsViewController = segue.destinationViewController;
        NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
        barDetailsViewController.selectedBar = self.data[indexPath.row];
    }
}

@end
