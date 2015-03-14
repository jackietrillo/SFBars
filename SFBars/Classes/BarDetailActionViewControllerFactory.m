//
//  BarsDetailActionViewControllerFactory.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/10/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailActionViewControllerFactory.h"

@implementation BarDetailActionViewControllerFactory

-(UIViewController*) viewControllerForAction: (BarDetailActionType)action withBar: (Bar*) bar {
    
    if (!bar) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:[NSString stringWithFormat:@"Parameter %@ cannot be null", NSStringFromClass ([Bar class])]
                                     userInfo:nil];
    }
   
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    UIViewController* barDetailActionViewController;
  
    switch (action) {
        case BarDetailActionTypeWebsite:
            
            barDetailActionViewController = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
            
            ((BarWebViewController*)barDetailActionViewController).url = bar.websiteUrl;

            break;
        case BarDetailActionTypeEvents:
             barDetailActionViewController = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
            
            ((BarWebViewController*)barDetailActionViewController).url = bar.calendarUrl;
            
            break;
        case BarDetailActionTypeFacebookPage:
            barDetailActionViewController = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
            
            ((BarWebViewController*)barDetailActionViewController).url = bar.facebookUrl;
            
            break;
        case BarDetailActionTypeYelpReviews:
            barDetailActionViewController = [storyboard instantiateViewControllerWithIdentifier:@"BarWebViewController"];
            
            ((BarWebViewController*)barDetailActionViewController).url = bar.yelpUrl;
            
            break;
        case BarDetailActionTypeMessage:
            barDetailActionViewController = [[MFMessageComposeViewController alloc] init];
            
            [(MFMessageComposeViewController*)barDetailActionViewController setSubject: bar.name];
            [(MFMessageComposeViewController*)barDetailActionViewController setBody:[NSString stringWithFormat:@"%@ - %@", bar.name, bar.address]];
            
            break;
            
        case BarDetailActionTypeEmail:
            barDetailActionViewController = [[MFMailComposeViewController alloc] init];
            
            [(MFMailComposeViewController*)barDetailActionViewController setSubject: bar.name];
            [(MFMailComposeViewController*)barDetailActionViewController setMessageBody: bar.address isHTML:YES];
            
            break;
        default:
            break;
    }
    
    return barDetailActionViewController;
}


@end
