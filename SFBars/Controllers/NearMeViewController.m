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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    //NSLog(@"%@", NSStringFromClass ([self class]));
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
    CLLocationCoordinate2D cameraLocation;
    if (self.mapView.myLocationEnabled) {
        cameraLocation =   CLLocationCoordinate2DMake(self.mapView.myLocation.coordinate.latitude, self.mapView.myLocation.coordinate.longitude);
    }
    else {
        cameraLocation =   CLLocationCoordinate2DMake(37.761622, -122.435285); //TODO: remove these hardcoded values
    }
    
    GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:cameraLocation.latitude longitude:cameraLocation.longitude zoom:0 bearing:0 viewingAngle:0];
    
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.buildingsEnabled = true;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;
    [self.mapView setMinZoom:10.0 maxZoom:20.0];
    
    self.view = self.mapView;
    
    [self.mapView animateToZoom:15];
    [self.mapView animateToViewingAngle:180];
}

-(GMSMarker*)createMarker:(Bar*)bar {
    GMSMarker* marker = [[GMSMarker alloc] init];
    marker.title = bar.name;
    marker.appearAnimation = kGMSMarkerAnimationNone;
    marker.snippet = bar.descrip;
    marker.position = CLLocationCoordinate2DMake(bar.latitude, bar.longitude);
    return marker;
}

@end
