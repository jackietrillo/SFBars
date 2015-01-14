//
//  StreetBarsViewController.h
//  Streets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "Street.h"

@interface BarsViewController : UIViewController

@property (nonatomic, strong) NSNumber* barTypeId;
@property (nonatomic, strong) IBOutlet UITableView* tableView;


@end
