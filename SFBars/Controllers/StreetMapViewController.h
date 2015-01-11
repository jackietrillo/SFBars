//
//  SFStreetMapViewController.h
//  SFStreets
//
//  Created by JACKIE TRILLO on 11/21/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <iAd/iAd.h>
#import "Street.h"
#import "Bar.h"

@interface StreetMapViewController : UIViewController

@property (readwrite, nonatomic, strong) Street* street;
@property (readwrite, nonatomic, strong) Bar* selectedBar;


@end
