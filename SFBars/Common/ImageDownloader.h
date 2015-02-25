//
//  ImageDownloader.h
//  SFBars
//
//  Created by JACKIE TRILLO on 1/21/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseEntity.h"

@interface ImageDownloader : NSObject

@property (nonatomic, strong) BaseEntity* entity;

@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;
@end
