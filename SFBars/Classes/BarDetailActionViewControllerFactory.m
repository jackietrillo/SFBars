//
//  BarsDetailActionViewControllerFactory.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/10/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarDetailActionViewControllerFactory.h"


@implementation BarsDetailActionViewControllerFactory



-(UIViewController*) controllerForAction: (BarDetailActionType)action withBar: (Bar*) bar {
    
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
        default:
            break;
    }
    
    return barDetailActionViewController;
}


@end
