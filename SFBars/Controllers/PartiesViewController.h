//
//  MusicViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 2/3/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "BaseViewController.h"
#import "MenuItem.h"

@interface PartiesViewController : BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) IBOutlet UICollectionView *collectionView;
@end
