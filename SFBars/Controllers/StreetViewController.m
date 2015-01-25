//
//  ViewController.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/11/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "StreetViewController.h"
#import "StreetTableViewCell.h"
#import "StreetManager.h"
#import "BarViewController.h"
#import "BarMapViewController.h"

@interface StreetViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (readwrite, nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation StreetViewController

static NSString* reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
    
    [self initController];
}

-(void)initController {
    StreetManager* streetManager = [[StreetManager alloc] init];
    self.dataSource = streetManager.streets;
    self.tableView.delegate = self;
    
    self.canDisplayBannerAds = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger rowIndex = indexPath.row;
    Street* street = self.dataSource[rowIndex];
    
    StreetTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier forIndexPath:indexPath];
    
    cell.nameLabel.text = street.name;
  
    return cell;
}

//Not used
-(void)addFilterToImageView: (UIImageView*)imageView {

     CIImage *beginImage = [CIImage imageWithCGImage:[imageView.image CGImage]];
     CIContext *context = [CIContext contextWithOptions:nil];
     
     CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, beginImage, @"inputIntensity", [NSNumber numberWithFloat:0.4], nil];
     
     CIImage *outputImage = [filter outputImage];
     
     CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
     UIImage *newImg = [UIImage imageWithCGImage:cgimg];
     
     [imageView setImage:newImg];
     
     CGImageRelease(cgimg);
}


- (void)animateTableCells
{
    if (self.dataSource.count > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            StreetTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: reuseIdentifier forIndexPath:indexPath];
            
            cell.backgroundView.alpha = 0;
            [UIView animateWithDuration:1
                             delay: 0.0
                             options: UIViewAnimationOptionCurveEaseInOut
                             animations:^(void) {
                                 cell.backgroundView.alpha = 1;
                             }
                             completion: ^(BOOL finished)
                             {
                             }];

        }
    }
}


#pragma mark - UIScrollViewDelegate

// -------------------------------------------------------------------------------
//	scrollViewDidEndDragging:willDecelerate:
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
      //  [self animateTableCells];
    }
}

// -------------------------------------------------------------------------------
//	scrollViewDidEndDecelerating:scrollView
//  When scrolling stops, proceed to load the app icons that are on screen.
// -------------------------------------------------------------------------------
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // [self animateTableCells];
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   //  NSIndexPath* indexPath =   [self.tableView indexPathForSelectedRow];
    // BarViewController* barsViewController = segue.destinationViewController;
    // barsViewController.street = self.dataSource[indexPath.row];
 }

@end
