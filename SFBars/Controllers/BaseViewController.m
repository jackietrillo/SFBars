//
//  BaseViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/7/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

NSString* kCellIdentifier = @"Cell";
NSString* kGlyphIconsFontName  = @"GLYPHICONSHalflings-Regular";
NSString* kFontAwesomeFontName  = @"FontAwesome";
NSString* kServiceUrl = @"http://www.sanfranciscostreets.net/api/bars/bar/";

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIBarButtonItem*)addMenuButtonToNavigation {

    UIFont* font = [UIFont fontWithName: kGlyphIconsFontName size:25.0];
    NSDictionary* attributesForNormalState =  @{ NSFontAttributeName: font};
    
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc] init];
    [menuButton setTitleTextAttributes: attributesForNormalState forState:UIControlStateNormal];
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    [menuButton setTarget:self];
    
    return menuButton;
}

//TODO: move into BarsGateWay
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
             //TODO: handle error
         }
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             if (arrayData != nil) {
                 [self loadData: arrayData];
             }
             else {
                //TODO: handle error
             }
         });
     }];
}

//TODO: move into BarsGateWay
-(NSMutableArray*)parseData: (NSData*)responseData {
    return nil;
}

//TODO: move into BarsGateWay
-(void)loadData: (NSMutableArray*) data {
   
}
@end
