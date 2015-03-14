//
//  EnumParser.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsEnumParser.h"

@implementation BarsEnumParser

+(BarDetailActionType)barDetailActionTypeEnumFromString:(NSString*)action {
    
    if ([action isEqualToString: NSLocalizedString(@"Website", @"Website")]) {
        return BarDetailActionTypeWebsite;
    }
    else if ([action isEqualToString: NSLocalizedString(@"Events", @"Events")]) {
        return BarDetailActionTypeEvents;
    }
    else if ([action isEqualToString: NSLocalizedString(@"Facebook Page", @"Facebook Page")]) {
        return BarDetailActionTypeFacebookPage;
    }
    else if ([action isEqualToString: NSLocalizedString(@"Yelp Reviews", @"Yelp Reviews")]) {
        return BarDetailActionTypeYelpReviews;
    }
    else if ([action isEqualToString: NSLocalizedString(@"Email", @"Email")]) {
        return BarDetailActionTypeEmail;
    }
    else if ([action isEqualToString: NSLocalizedString(@"Message", @"Message")]) {
        return BarDetailActionTypeMessage;
    }
    else {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:[NSString stringWithFormat:@"Could not convert string %@ to enum", action]
                                     userInfo:nil];
    }
}
@end
