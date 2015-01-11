//
//  SFStreetTabBarViewController.m
//  SFStreets
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "StreetTabBarViewController.h"

@interface SFStreetTabBarViewController ()

@end

@implementation SFStreetTabBarViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];

    [self initController];
}

-(void) initController {
    
    [self initTabBar];
}

-(void) initTabBar {
    
   // self.tabBar.backgroundColor = [UIColor blackColor];
    
    UITabBarItem* tabBarItemBar = [self.tabBar.items objectAtIndex:0];
    //UITabBarItem* tabBarItemFav = [self.tabBar.items objectAtIndex:1];

    //name="GLYPHICONSHalflings-Regular" family="GLYPHICONS Halflings"
    
    UIFont* font = [UIFont fontWithName:@"fontawesome" size:33.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};

    [tabBarItemBar setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    
    //[tabBarItemFav setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    
    [tabBarItemBar setTitle:[NSString stringWithUTF8String:"\uf000"]];
   // [tabBarItemFav setTitle:[NSString stringWithUTF8String:"\uf006"]];
    
    [tabBarItemBar setTitlePositionAdjustment:UIOffsetMake(0.0, -10.0)];
    //[tabBarItemFav setTitlePositionAdjustment:UIOffsetMake(0.0, -12.0)];
    
    [self hideTabBar:self];
    
}

- (void) hideTabBar:(UITabBarController *) tabbarcontroller
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    float fHeight = screenRect.size.height;
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width;
    }
    
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
            view.backgroundColor = [UIColor blackColor];
        }
    }
    [UIView commitAnimations];
}

- (void) showTabBar:(UITabBarController *) tabbarcontroller
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    float fHeight = screenRect.size.height - tabbarcontroller.tabBar.frame.size.height;
    
    if(  UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) )
    {
        fHeight = screenRect.size.width - tabbarcontroller.tabBar.frame.size.height;
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    for(UIView *view in tabbarcontroller.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setFrame:CGRectMake(view.frame.origin.x, fHeight, view.frame.size.width, view.frame.size.height)];
        }
        else
        {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, fHeight)];
        }
    }
    [UIView commitAnimations];
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
