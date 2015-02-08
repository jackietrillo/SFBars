//
//  NearMeViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/5/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "NearMeViewController.h"
#import "ConnectionHelper.h"

@interface NearMeViewController ()

@property (nonatomic, strong) GMSMapView* mapView;

@end

static NSString* serviceUrl = @"http://www.sanfranciscostreets.net/api/bars/bar/";

@implementation NearMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    [self initMapView];
    
    if (!self.appDelegate.cachedBars)
    {
        [self sendAsyncRequest:serviceUrl method:@"GET" accept:@"application/json"];
    }
    else
    {
        [self loadData: self.appDelegate.cachedBars];
    }
}

- (void)initNavigation {
    
    self.navigationItem.title = @"NEAR ME"; //TODO: localize
}

-(NSMutableArray*)parseData: (NSData*)responseData {
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
        //TODO: alert user
    }
    
    NSMutableArray* data = [[NSMutableArray alloc] init];
    if (arrayData.count > 0)
    {
        for (int i = 0; i < arrayData.count; i++)
        {
            NSDictionary* dictTemp = arrayData[i];
            Bar* bar = [Bar initFromDictionary:dictTemp];
            [data addObject:bar];
        }
    }
    
    return data;
}

-(void)loadData: (NSMutableArray*) data {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   
    if (!self.appDelegate.cachedBars) {
        self.appDelegate.cachedBars = data;
    }
    
    for(int i=0; i < data.count; i++) {
        GMSMarker* marker = [self createMarker:data[i]];
        marker.map = self.mapView;
    }
}

-(void)initMapView {
    
    CLLocationCoordinate2D cameraLocation;
    if (self.mapView.myLocationEnabled) {
        cameraLocation =   CLLocationCoordinate2DMake(self.mapView.myLocation.coordinate.latitude, self.mapView.myLocation.coordinate.longitude);
    }
    else {
        cameraLocation =   CLLocationCoordinate2DMake(37.761622, -122.435285); //TODO: remove hardcoded constants
    }
    
    GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:cameraLocation.latitude longitude:cameraLocation.longitude zoom:15 bearing:0 viewingAngle:120];
    
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.buildingsEnabled = true;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.settings.compassButton = YES;
    [self.mapView setMinZoom:10.0 maxZoom:20.0];
    
    self.view = self.mapView;
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
