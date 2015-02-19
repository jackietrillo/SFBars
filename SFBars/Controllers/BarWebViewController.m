//
//  BarWebViewController.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/29/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BarWebViewController.h"

@interface BarWebViewController ()

@end

@implementation BarWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSString* className = NSStringFromClass ([self class]);
    NSLog(@"%@", className);
}
-(void)initWebView {
    
    self.canDisplayBannerAds = YES;
   
    NSString* backButtonText = [NSString stringWithUTF8String:"\uf053"]; //chevron
    backButtonText = [backButtonText stringByAppendingString: @" Back"];
    [self.backButton setTitle: backButtonText forState:UIControlStateNormal];
    
    if (self.url != nil)
    {
        NSURL* launchURL = [NSURL URLWithString:self.url];
        NSURLRequest* request = [NSURLRequest requestWithURL:launchURL];
        [self.webView loadRequest:request];
        
         self.webView.scalesPageToFit = YES;
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Calendar is not avaible at this time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
