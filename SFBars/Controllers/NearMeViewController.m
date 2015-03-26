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
    
    [self initNavigation];
   
    [self initMapView];
    
    [self showLoadingIndicator];
    
    [self.barsFacade getBars: ^(NSArray* data) {
        if (data) {
            for(int i=0; i < data.count; i++) {
                GMSMarker* marker = [self createMarker:data[i]];
                marker.map = self.mapView;
            }
        }
        [self hideLoadingIndicator];
    }];
}

-(void)initNavigation {
    [self addMenuButtonToNavigation];
    self.navigationItem.title = NSLocalizedString(@"NEAR ME", @"NEAR ME");
}

-(void)loadData:(NSArray*) data {
    if (data) {
        for(int i=0; i < data.count; i++) {
            GMSMarker* marker = [self createMarker:data[i]];
            marker.map = self.mapView;
        }
    }
}

-(void)initMapView {
   
    self.mapView.settings.myLocationButton  = YES;
    self.mapView.myLocationEnabled = YES;
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D cameraLocation;
    if (self.mapView.myLocationEnabled) {
        cameraLocation =   CLLocationCoordinate2DMake(self.mapView.myLocation.coordinate.latitude, self.mapView.myLocation.coordinate.longitude);
    }
    else {
        cameraLocation =   CLLocationCoordinate2DMake(37.776507, -122.435767);
    }
    
    GMSCameraPosition* cameraPosition = [GMSCameraPosition cameraWithLatitude:cameraLocation.latitude longitude:cameraLocation.longitude zoom:9 bearing:0 viewingAngle:0];
    
    self.mapView = [[GMSMapView alloc] initWithFrame:self.view.bounds];
    [self.mapView animateToCameraPosition:cameraPosition];
    self.view = self.mapView;
    
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.buildingsEnabled = true;
    self.mapView.settings.compassButton = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.mapView animateToZoom:11.5];
        [self.mapView animateToViewingAngle:40.0];
    });
    
}

-(GMSMarker*)createMarker:(Bar*)bar {
    GMSMarker* marker = [[GMSMarker alloc] init];
    marker.title = bar.name;
    marker.appearAnimation = kGMSMarkerAnimationNone;
    marker.snippet = bar.descrip;
    marker.position = CLLocationCoordinate2DMake(bar.latitude, bar.longitude);
    return marker;
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}
@end
