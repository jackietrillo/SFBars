//
//  StreetBarsViewController.h
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "ImageDownloader.h"
#import "BarsViewControllerBase.h"
#import "BarWebViewController.h"
#import "BarDetailViewController.h"
#import "BarTableViewCell.h"
#import "LoadingView.h"
#import "Bar.h"
#import "Enums.h"


@interface BarViewController : BarsViewControllerBase <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (readwrite, nonatomic, strong) NSString* titleText;
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (readwrite, nonatomic) FilterType filterType;
@property (readwrite, nonatomic) NSArray* filterIds; // note filterIds depend on the filterType


@end
