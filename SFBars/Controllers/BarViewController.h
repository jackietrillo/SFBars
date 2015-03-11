//
//  StreetBarsViewController.h
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "ImageDownloader.h"
#import "BaseViewController.h"
#import "BarWebViewController.h"
#import "BarDetailViewController.h"
#import "BarTableViewCell.h"
#import "LoadingView.h"
#import "Bar.h"
#import "Enums.h"


@interface BarViewController : BaseViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (readwrite, nonatomic, strong) NSString* titleText;
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (readwrite, nonatomic) FilterType filterType;
@property (readwrite, nonatomic) NSArray* filterIds;

@property (readwrite, nonatomic, strong) NSMutableArray* bars;

@end
