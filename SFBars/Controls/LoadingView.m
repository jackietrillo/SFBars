//
//  LoadingView.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/21/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView


- (void)awakeFromNib {
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = CGPointMake(160, 240);
    [self addSubview:spinner];
    [spinner startAnimating];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {

 }
*/

@end
