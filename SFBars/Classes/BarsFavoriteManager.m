//
//  BarsFavoriteManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsFavoriteManager.h"

@implementation BarsFavoriteManager

static NSString* SAVEDBARSDICT = @"savedBarsDict";

-(NSArray*)getFavoriteBars {
    return nil;
}

-(void)saveFavorite:(Bar*)bar {
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
     NSMutableDictionary* savedBarsDict = [[defaults dictionaryForKey:SAVEDBARSDICT] mutableCopy];
     
     if (savedBarsDict == nil) {
     savedBarsDict = [[NSMutableDictionary alloc] init];
     }
     
     NSString* barIdAsString =  [NSString stringWithFormat:@"%d", (int)bar.barId];
     
     NSObject* barId =  [savedBarsDict objectForKey:barIdAsString];
     
     if (barId == nil) {
         [savedBarsDict setValue:barIdAsString forKey:barIdAsString];
     }
    
     else {
     
     [savedBarsDict removeObjectForKey:barIdAsString];
     
     
     }
     
     [defaults setObject:savedBarsDict forKey:SAVEDBARSDICT];
}

-(bool)favoriteExits:(Bar*)bar {
    return YES;
}


-(void)removeFavorite:(Bar*)bar {

}

@end
