//
//  BarWebViewController.h
//  Streets
//
//  Created by JACKIE TRILLO on 11/29/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface BarWebViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIWebView* webView;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* backButton;
@property (nonatomic, strong) NSString* url;



@end
