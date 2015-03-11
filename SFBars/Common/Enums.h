//
//  Enums.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/12/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

typedef enum {
    FilterByNotAssigned = -1,
    FilterByBarTypes = 0,
    FilterByDistricts = 1,
    FilterByMusicTypes = 2,
    FilterByBarIds = 3
} FilterType;


typedef enum {
    AppleMaps = 0,
    GoogleMaps = 1,
} VendorMaps;


typedef enum {
    BarDetailActionTypePhone = 0,
    BarDetailActionTypeWebsite = 1,
    BarDetailActionTypeEvents = 2,
    BarDetailActionTypeFacebookPage = 3,
    BarDetailActionTypeYelpReviews = 4
} BarDetailActionType;
