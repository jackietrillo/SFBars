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
    
    [self initController];
}

-(void)initController {
    self.canDisplayBannerAds = YES;
    self.webView.scalesPageToFit = YES;
    [self.closeButton setTitle:[NSString stringWithUTF8String:"\uf00d"] forState:UIControlStateNormal];
    self.closeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    NSURL* launchURL = [NSURL URLWithString:self.url];
    NSURLRequest* requestObj = [NSURLRequest requestWithURL:launchURL];
    [self.webView loadRequest:requestObj];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
