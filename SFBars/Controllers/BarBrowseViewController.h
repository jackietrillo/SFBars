//
//  BarBrowseViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/16/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsViewControllerBase.h"
#import "BarViewController.h"

@interface BarBrowseViewController : BarsViewControllerBase <UITableViewDelegate, UITableViewDataSource>

@property (readwrite, nonatomic, strong) IBOutlet UIScrollView* eventsScrollView;
@property (readwrite, nonatomic, strong) IBOutlet UITableView* browseMenuTableView;


@end
