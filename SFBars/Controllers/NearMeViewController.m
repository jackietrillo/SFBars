//
//  NearMeViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/5/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "NearMeViewController.h"

@interface NearMeViewController ()

@property (nonatomic, strong) GMSMapView* mapView;

@end

@implementation NearMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:37.761622 longitude:-122.435285 zoom:15];
    
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;
    [self.mapView setMinZoom:10.0 maxZoom:18.0];
    
    self.view = self.mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
