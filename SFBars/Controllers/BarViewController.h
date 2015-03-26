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
#import "BarViewTableViewCell.h"
#import "LoadingView.h"
#import "Bar.h"

typedef enum {
    BarsFilterByNotAssigned = -1,
    BarsFilterByBarType = 0,
    BarsFilterByDistrict = 1,
    BarsFilterByMusicType = 2,
    BarsFilterByBars = 3
} BarsFilterBy;

@interface BarViewController : BarsViewControllerBase <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (readwrite, nonatomic, strong) NSString* titleText;
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (readwrite, nonatomic) BarsFilterBy filterBy;
@property (readwrite, nonatomic) NSArray* filterIds; 


@end
