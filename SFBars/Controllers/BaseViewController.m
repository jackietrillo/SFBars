//
//  BaseViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/7/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (readwrite, nonatomic, strong) BarsGateway* barsGateway;

@end

NSString* kCellIdentifier = @"Cell";
NSString* kGlyphIconsFontName  = @"GLYPHICONSHalflings-Regular";
NSString* kFontAwesomeFontName  = @"FontAwesome";

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate] ;
    
    self.barsGateway = self.appDelegate.barsGateway;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addMenuButtonToNavigation {

    UIFont* font = [UIFont fontWithName: kGlyphIconsFontName size:25.0];
    NSDictionary* attributesForNormalState =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    [barButtonItem setTitleTextAttributes: attributesForNormalState forState:UIControlStateNormal];
    [barButtonItem setTitle:[NSString stringWithUTF8String:"\ue012"]];
   
    [barButtonItem setTarget:self];
    [barButtonItem setAction:@selector(presentMenuViewController:)];
    
    self.navigationItem.leftBarButtonItem = barButtonItem;
}  

- (void)addDoneButtonToNavigation {

    UIFont* font = [UIFont fontWithName: kFontAwesomeFontName size:30.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] init];
    
    [barButtonItem setTarget:self];
    [barButtonItem setAction:@selector(presentBrowseViewController:)];
    [barButtonItem setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [barButtonItem setTitle:[NSString stringWithUTF8String:"\uf00c"]];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

-(void)showLoadingIndicator {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSArray* xib = [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:nil options:nil];
    
    self.loadingView = [xib lastObject];
    self.loadingView.frame = self.view.bounds;
    
    [self.view addSubview:self.loadingView];
}

-(void)hideLoadingIndicator {

    if (self.loadingView) {
        self.loadingView.hidden = YES;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)presentMenuViewController:(id)sender {
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BaseViewController* viewController = [storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)presentBrowseViewController: (id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
