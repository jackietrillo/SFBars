//
//  SFStreetMapViewController.h
//  SFStreets
//
//  Created by JACKIE TRILLO on 11/21/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import <MapKit/MapKit.h>
#import "Bar.h"


@interface BarMapViewController : UIViewController

@property (readwrite, nonatomic, strong) Bar* selectedBar;
@property (readwrite, nonatomic, strong) CLLocation* currentLocation;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* backButton;
@end
