//
//  StreetBarsViewController.h
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "ImageDownloader.h"
#import "BarWebViewController.h"
#import "BarDetailsViewController.h"
#import "BarMapViewController.h"
#import "Bar.h"
#import "BarTableViewCell.h"


@interface BarViewController : UIViewController

@property (readwrite, nonatomic, strong) NSString* titleText;
@property (nonatomic, strong) IBOutlet UITableView* tableView;

@property (readwrite, nonatomic, strong) NSMutableArray* bars;
@property (readwrite, nonatomic, strong) NSMutableArray* savedBars;
@end
