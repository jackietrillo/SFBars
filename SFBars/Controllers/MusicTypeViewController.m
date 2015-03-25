//
//  MusicViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/3/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MusicTypeViewController.h"

@interface MusicTypeViewController ()

@property (readwrite, nonatomic, strong) NSArray* musicTypesData;

@end

@implementation MusicTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavigation];
    [self initMusicTypeCollectionView];
   
    [self showLoadingIndicator];
    [self.barsFacade getMusicTypes: ^(NSArray* data) {
        if (data) {
            self.musicTypesData = data;
            [self.collectionView reloadData];
        }
        self.collectionView.hidden = NO;
        [self hideLoadingIndicator];
    }];
}

-(void)initNavigation {
    self.navigationItem.title = NSLocalizedString(@"MUSIC", @"MUSIC");
    
    // Hack to remove text from back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)initMusicTypeCollectionView {
    self.collectionView.hidden = YES;
    self.collectionView.delegate = self;
}

-(void)setMusicTypeCollectionViewCellStyle:(UICollectionViewCell*)collectionViewCell {
    
    collectionViewCell.layer.borderWidth= 1.0f;
    collectionViewCell.layer.borderColor=[UIColor whiteColor].CGColor;
}

#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.musicTypesData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    UIImageView* imageView = (UIImageView*)[collectionViewCell viewWithTag:1];
    imageView.frame = collectionViewCell.bounds;
    imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    
    UILabel* textlabel = (UILabel*)[collectionViewCell viewWithTag:2];
    
    MusicType* musicType = (MusicType*)self.musicTypesData[indexPath.row];
    
    textlabel.text = musicType.name;
    
    [self setMusicTypeCollectionViewCellStyle:collectionViewCell];
    
    return collectionViewCell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath* indexPath =   [self.collectionView indexPathForCell:sender];
   
    BarViewController* barViewController = segue.destinationViewController;
    
    MusicType* musicType = self.musicTypesData[indexPath.row];
    
    barViewController.titleText = musicType.name;
    barViewController.filterBy = BarsFilterByMusicType;
    barViewController.filterIds = @[[[NSNumber numberWithInteger:musicType.itemId] stringValue]];
}

@end
