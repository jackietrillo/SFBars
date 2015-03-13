//
//  BarsFavoriteManager.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/13/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "Bar.h"

@interface BarsFavoriteManager : NSObject

-(NSArray*)getFavoriteBars;
-(bool)favoriteExits:(Bar*)bar;
-(void)saveFavorite:(Bar*)bar;
-(void)removeFavorite:(Bar*)bar;
@end
