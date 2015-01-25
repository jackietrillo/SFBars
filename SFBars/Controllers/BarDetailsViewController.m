//
//  BarDetailsViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 1/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailsViewController.h"

@interface BarDetailsViewController () <MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>

@property  (readwrite, nonatomic)  CLLocationManager* locationManager;
@property (readwrite, nonatomic, strong) CLLocation* currentLocation;

@end

@implementation BarDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initController];
}

-(void)initController
{
    //back button
    NSString* backButtonText = [NSString stringWithUTF8String:"\uf053"]; //chevron
    backButtonText = [backButtonText stringByAppendingString: @" Back"];
    [self.backButton setTitle: backButtonText forState:UIControlStateNormal];
    
    self.nameLabel.text = self.selectedBar.name;
    self.descripLabel.text = self.selectedBar.descrip;
    self.addressLabel.text = self.selectedBar.address;
    
    //action buttons
    [self.websiteButton setTitle: [NSString stringWithUTF8String:"\uf015"] forState:UIControlStateNormal];
    [self.calendarButton setTitle: [NSString stringWithUTF8String:"\uf073"] forState:UIControlStateNormal];
    [self.mapsButton setTitle: [NSString stringWithUTF8String:"\uf041"] forState:UIControlStateNormal];
    [self.facebookButton setTitle: [NSString stringWithUTF8String:"\uf09a"] forState:UIControlStateNormal];
    [self.yelpButton setTitle: [NSString stringWithUTF8String:"\uf1e9"] forState:UIControlStateNormal];
    [self.messageButton setTitle: [NSString stringWithUTF8String:"\uf075"] forState:UIControlStateNormal];
    [self.emailButton setTitle: [NSString stringWithUTF8String:"\uf003"] forState:UIControlStateNormal];
    
    //logo
    if (self.selectedBar.icon != nil)
    {
        self.logo.image = self.selectedBar.icon;
    }
    else
    {
        self.logo.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    }
    
   // [self initLocationManager];
    
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
           //NSLog(@"Cancelled");
            break;
        case MFMailComposeResultSaved:
           ///NSLog(@"Saved");
            break;
        case MFMailComposeResultSent:
           //NSLog(@"Sent");
            break;
        case MFMailComposeResultFailed:
           //NSLog(@"Failed");
            break;
        default:
           //NSLog(@"Not sent");
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result)
    {
        case MessageComposeResultCancelled:
            //NSLog(@"Cancelled");
            break;
        case MessageComposeResultSent:
            ///NSLog(@"Sent");
            break;
        case MessageComposeResultFailed :
            //NSLog(@"Failed");
            break;
        default:
            //NSLog(@"Not sent");
            break;
    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Events

-(IBAction)tappedSendMail:(id)sender
{
   MFMailComposeViewController* mailComposeViewController = [[MFMailComposeViewController alloc] init];
   [mailComposeViewController setSubject:self.selectedBar.name];
   [mailComposeViewController setMessageBody:self.selectedBar.address isHTML:YES];
    mailComposeViewController.mailComposeDelegate = self;
    
   [self presentViewController:mailComposeViewController animated:YES completion:nil];
}

-(IBAction)tappedSendSMS:(id)sender
{
    MFMessageComposeViewController* messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    [messageComposeViewController setSubject:self.selectedBar.name];
    
    NSString* messageBody = [NSString stringWithFormat:@"%@ - %@", self.selectedBar.name, self.selectedBar.address];
    [messageComposeViewController setBody:messageBody];
    messageComposeViewController.messageComposeDelegate = self;
    
    [self presentViewController:messageComposeViewController animated:YES completion:nil];
}

/*
-(void)initLocationManager
{
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.locationManager.distanceFilter = 500;
    
    [self.locationManager requestAlwaysAuthorization]; //TODO: test in iOS 7

    [self.locationManager startUpdatingLocation];
}
 */

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = [locations lastObject];
}

#pragma mark - Navigation

 - (IBAction)unwindToBarDetails:(UIStoryboardSegue *)unwindSegue
 {
 
 }

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass: [BarWebViewController class]])
    {
        BarWebViewController* barWebViewController = segue.destinationViewController;
        
        if ([segue.identifier isEqualToString: @"websiteSegue"])
        {
            barWebViewController.url = self.selectedBar.websiteUrl;
        }
        if ([segue.identifier isEqualToString: @"calendarSegue"])
        {
            barWebViewController.url = self.selectedBar.calendarUrl;
        }
        if ([segue.identifier isEqualToString: @"facebookSegue"])
        {
            barWebViewController.url = self.selectedBar.facebookUrl;
        }
        if ([segue.identifier isEqualToString: @"yelpSegue"])
        {
            barWebViewController.url = self.selectedBar.yelpUrl;
        }
    }
    
    if ([segue.destinationViewController isKindOfClass: [BarMapViewController class]])
    {
        BarMapViewController* barMapViewController = segue.destinationViewController;

        barMapViewController.currentLocation = self.currentLocation;
        barMapViewController.selectedBar = self.selectedBar;
    }

}


@end
