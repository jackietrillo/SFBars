//
//  Cache.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

@interface BarCache : NSObject

@property (readwrite, nonatomic, strong) NSArray* cachedBars;
@property (readwrite, nonatomic, strong) NSArray* cachedBarTypes;
@property (readwrite, nonatomic, strong) NSArray* cachedDistricts;
@property (readwrite, nonatomic, strong) NSArray* cachedParties;
@property (readwrite, nonatomic, strong) NSArray* cachedEvents;
@property (readwrite, nonatomic, strong) NSArray* cachedMusicTypes;
@property (readwrite, nonatomic, strong) NSArray* cachedBarDetails;
@property (readwrite, nonatomic, strong) NSArray* cachedMenuItems;
@property (readwrite, nonatomic, strong) NSArray* cachedSettings;

@end
