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
    
    self.canDisplayBannerAds = YES;

    [self initWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"%@", NSStringFromClass ([self class]));
}

-(void)initWebView {
    if (self.url != nil) {
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:request];
        self.webView.scalesPageToFit = YES;
    }
    else {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"Info", @"Info")
                                                        message: NSLocalizedString(@"Requested page is not avaible at this time.", @"Requested page is not avaible at this time.")
                                                       delegate: self
                                              cancelButtonTitle: NSLocalizedString(@"OK", @"OK")
                                              otherButtonTitles: nil];
        [alert show];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
