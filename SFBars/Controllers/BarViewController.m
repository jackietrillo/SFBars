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

@end

@implementation BarViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    self.canDisplayBannerAds = YES;
    [self initNavigation];
    
    if (self.bars != nil) {
        self.data = self.bars;
    }
    else {
        //TODO: alert user
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
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
       //TODO: alert user
    }
    
    NSMutableArray* bars = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++)
        {
            NSDictionary* dictTemp = arrayData[i];
            Bar* bar = [Bar initFromDictionary:dictTemp];
            [bars addObject:bar];
        }
    }
    
    return bars;
}

-(void)loadData: (NSMutableArray*) arrayData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
    self.data = arrayData;
    
    [self.tableView reloadData];
    self.tableView.hidden = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowIndex = indexPath.row;
    Bar* bar = self.data[rowIndex];
    
    BarTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.nameLabel.text = bar.name;
    cell.descripLabel.text = bar.descrip;
    cell.addressLabel.text = bar.address;
    cell.hoursLabel.text = bar.hours;
    cell.websiteButton.tag = indexPath.row;
    cell.mapButton.tag = indexPath.row;
    
    if (!bar.icon)
    {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        {
            [self startImageDownload:bar forIndexPath:indexPath];
        }
        // if a download is deferred or in progress, return a placeholder image
        cell.logo.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    }
    else
    {
       // UIImage* filteredImage = [self addFilterToImage: bar.icon];
        cell.logo.image = bar.icon;
    }

    return cell;
}

-(UIImage*)addFilterToImage: (UIImage*)image {
    
    CIContext *imgContext = [CIContext contextWithOptions:nil];
    
    CIImage *bgnImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter *imgFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, bgnImage, @"inputIntensity", [NSNumber numberWithFloat:0.5], nil];
    CIImage *myOutputImage = [imgFilter outputImage];
    
    CGImageRef cgImgRef = [imgContext  createCGImage:myOutputImage fromRect:[myOutputImage extent]];
    UIImage *newImgWithFilter = [UIImage imageWithCGImage:cgImgRef];
    
    CGImageRelease(cgImgRef);
    return newImgWithFilter;
    
}

-(void)addFilterToImageView: (UIImageView*)imageView {
    
    CIContext *imgContext = [CIContext contextWithOptions:nil];
    
    CIImage *bgnImage = [[CIImage alloc] initWithImage:imageView.image];
    
    CIFilter *imgFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, bgnImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *myOutputImage = [imgFilter outputImage];
    
    CGImageRef cgImgRef = [imgContext  createCGImage:myOutputImage fromRect:[myOutputImage extent]];
    UIImage *newImgWithFilter = [UIImage imageWithCGImage:cgImgRef];
    
    [imageView setImage:newImgWithFilter];
    
    CGImageRelease(cgImgRef);
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell
{
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = color;
    [cell setSelectedBackgroundView:bgColorView];
}

#pragma mark - Table cell image download support

- (void)terminateImageDownloads
{
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    self.tableView.hidden = YES;
    [self.imageDownloadsInProgress removeAllObjects];
}

- (void)startImageDownload:(Bar*)bar forIndexPath:(NSIndexPath *)indexPath
{
    ImageDownloader *imageDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (imageDownloader == nil)
    {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.Entity = bar;
    
        [imageDownloader setCompletionHandler:^{
            
            BarTableViewCell* cell = (BarTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        
            if (bar.icon != nil)
            {
                cell.logo.image = bar.icon;
            }
            else
            {
                cell.logo.image = [UIImage imageNamed:@"DefaultImage-Bar"];
            }
            
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
      
        (self.imageDownloadsInProgress)[indexPath] = imageDownloader;
        [imageDownloader startDownload];
    }
}

- (void)loadImagesForOnscreenRows
{
    if (self.data.count > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            Bar* bar = (self.data)[indexPath.row];
            
            if (!bar.icon)  // Avoid the download if there is already an icon
            {
                [self startImageDownload:bar forIndexPath:indexPath];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass: [BarDetailsViewController class]])
    {
        BarDetailsViewController* barDetailsViewController = segue.destinationViewController;
        NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
        barDetailsViewController.selectedBar = self.data[indexPath.row];
    }
}

@end
