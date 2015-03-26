//
//  BaseViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/7/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsViewControllerBase.h"

@interface BarsViewControllerBase ()

@property (readwrite, nonatomic, strong) BarsFacade* barsFacade;

@end

NSString* kCellIdentifier = @"Cell";
NSString* kGlyphIconsFontName  = @"GLYPHICONSHalflings-Regular";
NSString* kFontAwesomeFontName  = @"FontAwesome";

@implementation BarsViewControllerBase

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate] ;
    
    self.barsFacade = appDelegate.barsFacade;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

-(void)addMenuButtonToNavigation {
    [self setupMenuBarButtonItems];
}

- (void)setupMenuBarButtonItems {
    self.navigationItem.rightBarButtonItem = [self rightSideMenuBarButtonItem];
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self leftSideMenuBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = [self leftSideMenuBarButtonItem];
    }
}

#pragma mark - UIBarButtonItems

-(UIBarButtonItem*)leftSideMenuBarButtonItem {
    UIFont* font = [UIFont fontWithName: kGlyphIconsFontName size:25.0];
    NSDictionary* attributesForNormalState =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    [barButtonItem setTitleTextAttributes: attributesForNormalState forState:UIControlStateNormal];
    [barButtonItem setTitle:[NSString stringWithUTF8String:"\ue012"]];
    
    [barButtonItem setTarget:self];
    [barButtonItem setAction:@selector(leftSideMenuBarButtonItemPressed:)];
    
    return barButtonItem;
}

-(UIBarButtonItem*)rightSideMenuBarButtonItem {
    UIFont* font = [UIFont fontWithName: kGlyphIconsFontName size:25.0];
    NSDictionary* attributesForNormalState =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    [barButtonItem setTitleTextAttributes: attributesForNormalState forState:UIControlStateNormal];
    [barButtonItem setTitle:[NSString stringWithUTF8String:"\ue019"]];
    
    [barButtonItem setTarget:self];
    [barButtonItem setAction:@selector(rightSideMenuButtonPressed:)];
    
    return barButtonItem;
}

#pragma mark - UIBarButtonItem Callbacks

- (void)leftSideMenuBarButtonItemPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

#pragma mark - Loading Indicator

-(void)showLoadingIndicator {
    NSArray* loadingViewNib = [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:nil options:nil];
    
    self.loadingView = [loadingViewNib lastObject];
    self.loadingView.frame = self.view.bounds;
    
    [self.view addSubview:self.loadingView];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)hideLoadingIndicator {
    if (self.loadingView) {
        self.loadingView.hidden = YES;
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
