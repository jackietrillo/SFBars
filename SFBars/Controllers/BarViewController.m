//
//  StreetBarsViewController.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BarViewController.h"

@interface BarViewController () 

@property (readwrite, nonatomic, strong) NSArray* barsData;
@property (nonatomic, nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation BarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canDisplayBannerAds = YES;
    
    [self initNavigation];
    
    [self showLoadingIndicator];
    
    self.tableView.hidden = YES;
    
    self.tableView.delegate = self;
    
    [self.barsGateway getBars: ^(NSArray* data) {
        if (data) {
            
            if (self.filterType != FilterByNotAssigned && self.filterIds) {
                self.barsData = [self filterBars:data];
            }
            else {
                self.barsData = data;
            }
            
            [self.tableView reloadData];
        }
        self.tableView.hidden = NO;
        [self hideLoadingIndicator];
    }];
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
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

-(NSArray*)filterBars: (NSArray*) data {
    
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

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = color;
    [cell setSelectedBackgroundView:bgColorView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.barsData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    Bar* bar = self.barsData[rowIndex];
    
    BarTableViewCell* barTableViewCell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
    
    barTableViewCell.nameLabel.text = bar.name;

    if (!bar.icon) {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
            [self startImageDownload:bar forIndexPath:indexPath];
        }
        // if a download is deferred or in progress, return a placeholder image
        barTableViewCell.logo.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    }
    else {
        barTableViewCell.logo.image = bar.icon;
    }

    return barTableViewCell;
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
    if (self.barsData.count > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            Bar* bar = (self.barsData)[indexPath.row];
            
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
    if ([segue.destinationViewController isKindOfClass: [BarDetailViewController class]]) {
        BarDetailViewController* barDetailViewController = segue.destinationViewController;
        NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
        barDetailViewController.selectedBar = self.barsData[indexPath.row];
    }
}

@end
