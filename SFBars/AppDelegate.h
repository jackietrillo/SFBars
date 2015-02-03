//
//  AppDelegate.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/11/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readwrite, nonatomic, strong) NSMutableArray*  cachedBars;
@property (readwrite, nonatomic, strong) NSMutableArray*  cachedBarTypes;

@end

