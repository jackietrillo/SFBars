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

@property (readwrite, nonatomic, strong) Street* street;
@property (nonatomic, strong) IBOutlet UITableView* tableView;


-(IBAction)unWindToBar:(UIStoryboardSegue*)segue;

@end
