//
//  StreetMapViewController.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/21/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BarMapViewController.h"

@interface BarMapViewController () <MKMapViewDelegate>

@property (nonatomic) BOOL isMapLoaded;
@property (nonatomic, weak) IBOutlet MKMapView* mapView;
@end

@implementation BarMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initController];
}

-(void) initController
{
    self.canDisplayBannerAds = YES;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.isMapLoaded = NO;
    
    //back button
    NSString* backButtonText = [NSString stringWithUTF8String:"\uf053"]; //chevron
    backButtonText = [backButtonText stringByAppendingString: @" Back"];
    [self.backButton setTitle: backButtonText forState:UIControlStateNormal];
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
    if (!self.isMapLoaded)
    {        
        //zoom in to the  region
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(self.selectedBar.latitude, self.selectedBar.longitude);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 10000, 10000)];
        [mapView setRegion:adjustedRegion animated:YES];

        //add bar pin
        MKPointAnnotation* pin = [[MKPointAnnotation alloc]init];
        pin.title = self.selectedBar.name;
        pin.coordinate = CLLocationCoordinate2DMake(self.selectedBar.latitude, self.selectedBar.longitude);
        [self.mapView addAnnotation:pin];
        
        if(self.currentLocation != nil)
        {
            //add user current location pin
            pin = [[MKPointAnnotation alloc]init];
            pin.title = @"Your Location";
            pin.coordinate = CLLocationCoordinate2DMake(self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude);
            [self.mapView addAnnotation:pin];
        }
        //select pin
        [self.mapView selectAnnotation:pin animated:true];
        
    }
    self.isMapLoaded = YES;
}

#pragma mark - MkMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
   
    //TODO: create annotation images for bars
    //view.image = [UIImage imageNamed:[NSString stringWithFormat:@"Annotation-%@",[view.annotation title]]];
    //view.backgroundColor = [UIColor blackColor];
}



@end