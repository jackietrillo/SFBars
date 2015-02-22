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
   
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc] init];
    
    UIFont* font = [UIFont fontWithName:glyphIconsFontName size:25.0];
    
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    [menuButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    
    [menuButton setTarget:self];
    
    [menuButton setAction:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    
    self.navigationItem.title = NSLocalizedString(@"MUSIC", @"MUSIC");
    
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


-(void)setCellStyle:(UICollectionViewCell*)cell {
    
    cell.layer.borderWidth=1.0f;
    
    cell.layer.borderColor=[UIColor whiteColor].CGColor;
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
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
    imageView.frame = cell.bounds;
    imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    
    UILabel* textlabel = (UILabel*)[cell viewWithTag:2];
    
    MusicType* musicType = (MusicType*)self.data[indexPath.row];
    textlabel.text = musicType.name;
    
    [self setCellStyle:cell];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath* indexPath =   [self.collectionView indexPathForCell:sender];
    BarViewController* barsViewController = segue.destinationViewController;
    MusicType* musicType = self.data[indexPath.row];
    barsViewController.titleText = musicType.name;
    barsViewController.filterIds = @[[[NSNumber numberWithInteger:musicType.itemId] stringValue]];
    barsViewController.filterType = FilterByMusicTypes;
}

- (void)showMenu:(id)sender {
 
 [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
