//
//  BaseEntity.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/21/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseEntity : NSObject

@property (readwrite, nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) UIImage* icon;

@end
