//
//  BarsFavoriteManager.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BarsFavoriteManager.h"

@interface BarsFavoriteManager()

@property (readwrite, nonatomic, strong) NSUserDefaults* defaults;
@property (readwrite, nonatomic, strong) NSMutableDictionary* favorites;

@end

@implementation BarsFavoriteManager

static NSString* BARFAVORITESKEY = @"barFavoritesKey";

-(id)init {
    self = [super init];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    
    self.favorites = [[self.defaults dictionaryForKey:BARFAVORITESKEY] mutableCopy];
    
    if (!self.favorites) {
        self.favorites = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)saveFavoritesToDefaults {
    [self.defaults setObject:self.favorites forKey:BARFAVORITESKEY];
}

-(NSArray*)getFavorites{
    return [self.favorites allValues];
}

-(void)saveFavorite:(NSInteger)barId {
     NSString* barIdAsString =  [NSString stringWithFormat:@"%ld", (long)barId];
    
     if (![self favoriteExits:barId]) {
         [self.favorites setValue:barIdAsString forKey:barIdAsString];
     }
     
    [self saveFavoritesToDefaults];
}

-(bool)favoriteExits:(NSInteger)barId {
    NSString* barIdAsString =  [NSString stringWithFormat:@"%ld", (long)barId];
    NSObject* barIdAsObject =  [self.favorites objectForKey:barIdAsString];
    
    if (barIdAsObject) {
        return YES;
    } else {
        return NO;
    }
}

-(void)removeFavorite:(NSInteger)barId {
    NSString* barIdAsString =  [NSString stringWithFormat:@"%ld", (long)barId];
    if ([self favoriteExits:barId]) {
        [self.favorites removeObjectForKey:barIdAsString];
    }
    [self saveFavoritesToDefaults];
}

@end
