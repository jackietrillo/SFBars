//
//  StreetBarsViewController.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BarViewController.h"

@interface BarViewController () 

@property (readwrite, nonatomic, strong) NSArray* bars;
@property (nonatomic, nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation BarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canDisplayBannerAds = YES;
    
    [self initNavigation];
    [self initTableView];
    
    [self showLoadingIndicator];
    [self.barsFacade getBars: ^(NSArray* data) {
        if (data) {
            if (self.filterBy != BarsFilterByNotAssigned && self.filterIds) {
                self.bars = [self filterBars:data];
            }
            else {
                self.bars = data;
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

-(void)initTableView {
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
}

// Todo move this out into seperate object - What pattern should to use here?
-(NSArray*)filterBars: (NSArray*) data {
    NSMutableArray* filteredBars = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < data.count; i++) {
        Bar* bar = (Bar*)data[i];
        
        switch (self.filterBy) {
            case BarsFilterByBarType:
                for (int j = 0; j < self.filterIds.count; j++) {
                    if ([bar.barTypes containsObject: self.filterIds[j]] ) {
                        [filteredBars addObject:bar];
                    }
                }
                break;
            case BarsFilterByDistrict:
                if ([self.filterIds containsObject: [[NSNumber numberWithInteger:bar.districtId] stringValue]]) {
                    [filteredBars addObject:bar];
                }
                break;
            case BarsFilterByMusicType:
                if ([self.filterIds containsObject: [[NSNumber numberWithInteger:bar.musicTypeId] stringValue]]) {
                    [filteredBars addObject:bar];
                }
                break;
            case BarsFilterByBars:
                if ([self.filterIds containsObject: [[NSNumber numberWithInteger:bar.barId] stringValue]]) {
                    [filteredBars addObject:bar];
                }
                break;
            default:
                break;
        }
    }
    return filteredBars;
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = color;
    [cell setSelectedBackgroundView:bgColorView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bars.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    Bar* bar = self.bars[rowIndex];
    
    BarViewTableViewCell* barTableViewCell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
    
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
    [self.imageDownloadsInProgress removeAllObjects];
}

- (void)startImageDownload:(Bar*)bar forIndexPath:(NSIndexPath *)indexPath {
    ImageDownloader *imageDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (imageDownloader == nil) {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.Entity = bar;
    
        [imageDownloader setCompletionHandler:^{
            BarViewTableViewCell* cell = (BarViewTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
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
    if (self.bars.count > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            Bar* bar = (self.bars)[indexPath.row];
            
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
        barDetailViewController.selectedBar = self.bars[indexPath.row];
    }
}

@end
