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
NSString* kServiceUrl = @"http://www.sanfranciscostreets.net/api/bars/bar/";

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
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

// TODO move to gateway
-(void)sendAsyncRequest: (NSString*)url method:(NSString*)method accept: (NSString*)accept {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [urlRequest setHTTPMethod:method];
    [urlRequest setValue:accept forHTTPHeaderField:@"Accept"];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue: queue
                           completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         NSMutableArray* arrayData;
         if (connectionError == nil && data != nil) {
             arrayData = [self parseData:data];
         }
         else {
             // TODO handle error
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             if (arrayData != nil) {
                 [self loadData: arrayData];
             }
             else {
                // TODO handle error
             }
         });
     }];
}

// TODO move to gateway
-(NSMutableArray*)parseData: (NSData*)responseData {
    return nil;
}

// TODO move to gateway
-(void)loadData: (NSMutableArray*) data {
   
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
