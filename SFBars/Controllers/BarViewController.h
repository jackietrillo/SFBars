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
#import "BaseViewController.h"
#import "BarWebViewController.h"
#import "BarDetailsViewController.h"
#import "BarTableViewCell.h"
#import "LoadingView.h"
#import "Bar.h"
#import "Enums.h"
#import "Constants.h"

@interface BarViewController : BaseViewController <UIScrollViewDelegate>

@property (readwrite, nonatomic, strong) NSString* titleText;
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (readwrite, nonatomic) FilterType filterType;
@property (readwrite, nonatomic) NSArray* filterIds;

@property (readwrite, nonatomic, strong) NSMutableArray* bars;

@end
