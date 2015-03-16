//
//  MusicViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/3/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "PartyViewController.h"

@interface PartyViewController()

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl* pageControl;
@property (nonatomic, strong) NSMutableArray* partyPageViewControllers;

@property (nonatomic, nonatomic, strong) NSMutableDictionary* imageDownloadsInProgress;
@property (readwrite, nonatomic) NSUInteger numberOfPages;
@property (readwrite, nonatomic, strong) NSArray* parties;
@end

@implementation PartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    
    [self showLoadingIndicator];
    
    [self.barsFacade getParties: ^(NSArray* data) {
        if (data) {
            self.parties = data;
            [self initPartyViewController];
        }
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

-(void)initPartyViewController {

    self.numberOfPages = self.parties.count;
    
    NSMutableArray* partyPageViewControllers = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < self.numberOfPages; i++) {
        [partyPageViewControllers addObject:[NSNull null]]; //lazy load later
    }
    self.partyPageViewControllers = partyPageViewControllers;
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.numberOfPages, CGRectGetHeight(self.scrollView.frame));
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    self.pageControl.numberOfPages = self.numberOfPages;
    self.pageControl.currentPage = 0;
    
    [self loadScrollViewWithPage:0];
}

-(void)initNavigation {
    [self addMenuButtonToNavigation];
    
    self.navigationItem.title = NSLocalizedString(@"PARTIES", @"PARTIES");
    
    // note Hack to remove text in back button on segued view controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)loadScrollViewWithPage:(NSUInteger)page {
    if (page > self.parties.count - 1) {
        return;
    }
    Party* party = [self.parties objectAtIndex:page];
    
    PartyPageViewController* partyPageViewController = [self.partyPageViewControllers objectAtIndex:page];
    if ((NSNull *)partyPageViewController == [NSNull null]) {
        partyPageViewController = [[PartyPageViewController alloc] initWithParty: party];
        [self.partyPageViewControllers replaceObjectAtIndex:page withObject:partyPageViewController];
    }
    
    if (partyPageViewController.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        partyPageViewController.view.frame = frame;
        
        [self addChildViewController: partyPageViewController];
        [self.scrollView addSubview: partyPageViewController.view];
        [partyPageViewController didMoveToParentViewController:self];
      
        if (!party.icon) {
            if (self.scrollView.dragging == NO && self.scrollView.decelerating == NO) {
                [self startImageDownload:party forIndexPath:[NSIndexPath indexPathForRow:page inSection:0]];
            }
            // if a download is deferred or in progress, return a placeholder image
            partyPageViewController.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page < self.numberOfPages ) {
        self.pageControl.currentPage = page;
        [self loadScrollViewWithPage:page];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
     [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
}

- (void)gotoPage:(BOOL)animated {
    NSInteger page = self.pageControl.currentPage;
    
    [self loadScrollViewWithPage:page];
    
    // update the scroll view to the appropriate page
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:animated];
}

- (IBAction)changePage:(id)sender {
    [self gotoPage:YES];
}

#pragma mark - Table cell image download support

- (void)terminateImageDownloads {
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [self.imageDownloadsInProgress removeAllObjects];
}

- (void)startImageDownload:(Party*)party forIndexPath:(NSIndexPath *)indexPath {
    ImageDownloader *imageDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (imageDownloader == nil) {
        imageDownloader = [[ImageDownloader alloc] init];
        imageDownloader.Entity = party;
        
        [imageDownloader setCompletionHandler:^{
            PartyPageViewController* partyPageViewController = (PartyPageViewController*)[self.partyPageViewControllers objectAtIndex:indexPath.row];
            if (party.icon) {
                partyPageViewController.imageView.image = party.icon; // download successful
            }
            else {
                partyPageViewController.imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"]; // download unsuccessful
            }
            
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
        }];
        
        (self.imageDownloadsInProgress)[indexPath] = imageDownloader;
        
        [imageDownloader startDownload];
    }
}

@end
