//
//  Cache.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/24/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

@interface Cache : NSObject

@property (readwrite, nonatomic, strong) NSMutableArray* cachedBars;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedBarTypes;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedDistricts;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedParties;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedEvents;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedMusicTypes;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedBarDetails;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedMenuItems;
@property (readwrite, nonatomic, strong) NSMutableArray* cachedSettings;

@end
