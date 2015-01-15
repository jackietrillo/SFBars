//
//  StreetMapViewController.m
//  Streets
//
//  Created by JACKIE TRILLO on 11/21/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import "StreetMapViewController.h"
#import "Bar.h"

@interface StreetMapViewController () <MKMapViewDelegate>

@property (nonatomic) BOOL isMapLoaded;
@property (nonatomic, weak) IBOutlet MKMapView* mapView;

@end

@implementation StreetMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initController];
}

-(void) initController {
    
    self.canDisplayBannerAds = YES;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.isMapLoaded = NO;
}

- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
    if (!self.isMapLoaded) {
        
        //zoom in to the  region
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(self.selectedBar.latitude, self.selectedBar.longitude);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 300, 300)];
        [mapView setRegion:adjustedRegion animated:YES];

        //Add pin
        MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
        pin.title = self.selectedBar.name;
        pin.coordinate = CLLocationCoordinate2DMake(self.selectedBar.latitude, self.selectedBar.longitude);
        [self.mapView addAnnotation:pin];
        
        //Select pin
        [self.mapView selectAnnotation:pin animated:true];
            
        
        /*
        for (int i= 0; i < self.street.bars.count; i++) {
            Bar* bar = self.street.bars[i];
            
            MKPointAnnotation *pin = [[MKPointAnnotation alloc]init];
            pin.title = bar.name;
            
            pin.coordinate = CLLocationCoordinate2DMake(bar.latitude, bar.longitude);
            [self.mapView addAnnotation:pin];
            
            if (bar.name == self.selectedBar.name) {
                [self.mapView selectAnnotation:pin animated:true];
            }
        }
         */
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