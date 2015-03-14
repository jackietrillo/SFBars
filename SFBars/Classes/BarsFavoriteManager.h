//
//  BarsFavoriteManager.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "Bar.h"

@interface BarsFavoriteManager : NSObject

-(NSArray*)getFavorites;
-(bool)favoriteExits:(NSInteger)barId;
-(void)saveFavorite:(NSInteger)barId;
-(void)removeFavorite:(NSInteger)barId;

@end
