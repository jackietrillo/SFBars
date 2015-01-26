//
//  NavigationViewController.m
//  SFStreets
//
//  Created by JACKIE TRILLO on 11/25/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController () <UINavigationControllerDelegate>

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  
    [self setToolbarHidden:YES animated:YES];
    [self setNavigationBarHidden:NO animated:NO];
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
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
