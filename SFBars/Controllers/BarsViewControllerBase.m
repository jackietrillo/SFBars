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
    
   // [self setupMenuBarButtonItems];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems {
    self.navigationItem.rightBarButtonItem = [self rightSettingsButton];
    if(self.menuContainerViewController.menuState == MFSideMenuStateClosed &&
       ![[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        self.navigationItem.leftBarButtonItem = [self leftMenuButton];
    } else {
        self.navigationItem.leftBarButtonItem = [self leftMenuButton];
    }
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"icon-menu"] style:UIBarButtonItemStylePlain
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"icon-menu"] style:UIBarButtonItemStylePlain
            target:self
            action:@selector(rightSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)backBarButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-arrow"]
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(backButtonPressed:)];
}


#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        [self setupMenuBarButtonItems];
    }];
}

-(UIBarButtonItem*)leftMenuButton {
    UIFont* font = [UIFont fontWithName: kGlyphIconsFontName size:25.0];
    NSDictionary* attributesForNormalState =  @{ NSFontAttributeName: font};
     
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    [barButtonItem setTitleTextAttributes: attributesForNormalState forState:UIControlStateNormal];
    [barButtonItem setTitle:[NSString stringWithUTF8String:"\ue012"]];
     
    [barButtonItem setTarget:self];
    [barButtonItem setAction:@selector(leftSideMenuButtonPressed:)];
     
    return barButtonItem;
}

-(UIBarButtonItem*)rightSettingsButton {
    UIFont* font = [UIFont fontWithName: kGlyphIconsFontName size:25.0];
    NSDictionary* attributesForNormalState =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    [barButtonItem setTitleTextAttributes: attributesForNormalState forState:UIControlStateNormal];
    [barButtonItem setTitle:[NSString stringWithUTF8String:"\ue012"]];
    
    [barButtonItem setTarget:self];
    [barButtonItem setAction:@selector(rightSideMenuButtonPressed:)];
    
    return barButtonItem;
}

-(void)addMenuButtonToNavigation {
  
    [self setupMenuBarButtonItems];
    
}

-(void)showLoadingIndicator {
    NSArray* xib = [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:nil options:nil];
    
    self.loadingView = [xib lastObject];
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

- (void)presentMenuViewController:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BarsViewControllerBase* viewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)presentBrowseViewController: (id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
