//
//  MusicViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/3/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MusicTypeViewController.h"

@interface MusicTypeViewController ()

@property (readwrite, nonatomic, strong) NSMutableArray* data;

@end

@implementation MusicTypeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.data = [self getMusicTypes];
}

-(void)initNavigation {
   
    [self addMenuButtonToNavigation];
    
    self.navigationItem.title = NSLocalizedString(@"MUSIC", @"MUSIC");
    
    //Hack to remove text from back button
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(NSMutableArray*)getMusicTypes{
    
    if (self.appDelegate.cachedMusicTypes) {
        return self.appDelegate.cachedMusicTypes;
    }
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"MusicTypes" ofType:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfFile:path];
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    jsonData = nil;
    
    NSMutableArray* musicTypes = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0) {
        
        for (int i = 0; i < arrayData.count; i++) {
            
            NSDictionary* dictTemp = arrayData[i];
            
            MusicType* musicType = [MusicType initFromDictionary: dictTemp];
            
            [musicTypes addObject:musicType];
        }
    }
    
    self.appDelegate.cachedMusicTypes = musicTypes;
    
    return musicTypes;
}


-(void)setTableViewCellStyle:(UICollectionViewCell*)collectionViewCell {
    
    collectionViewCell.layer.borderWidth=1.0f;
    
    collectionViewCell.layer.borderColor=[UIColor whiteColor].CGColor;
}

#pragma UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


}

#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.data.count;
        default:
            return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    UIImageView* imageView = (UIImageView*)[collectionViewCell viewWithTag:1];
    imageView.frame = collectionViewCell.bounds;
    imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    
    UILabel* textlabel = (UILabel*)[collectionViewCell viewWithTag:2];
    
    MusicType* musicType = (MusicType*)self.data[indexPath.row];
    
    textlabel.text = musicType.name;
    
    [self setTableViewCellStyle:collectionViewCell];
    
    return collectionViewCell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath* indexPath =   [self.collectionView indexPathForCell:sender];
   
    BarViewController* barViewController = segue.destinationViewController;
    
    MusicType* musicType = self.data[indexPath.row];
    
    barViewController.titleText = musicType.name;
    barViewController.filterIds = @[[[NSNumber numberWithInteger:musicType.itemId] stringValue]];
    barViewController.filterType = FilterByMusicTypes;
}


@end
