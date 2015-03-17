//
//  TelephoneHelper.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/14/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "TelephoneHelper.h"

@implementation TelephoneHelper

+(NSURL*)telephoneUrl:(NSString*)telephoneNumber {
    
    NSString* phoneNumber = [telephoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"tel:1-%@", phoneNumber]];
}

@end
