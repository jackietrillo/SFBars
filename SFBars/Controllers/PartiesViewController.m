//
//  MusicViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/3/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "PartiesViewController.h"

@interface PartiesViewController ()

@property (readwrite, nonatomic, strong) NSMutableArray* data;
@end

@implementation PartiesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initNavigation];
    
    [self getParties];
}

-(void)initNavigation {
    
    [self addMenuButtonToNavigation];
    
    self.navigationItem.title = NSLocalizedString(@"PARTIES", @"PARTIES");
    
    // note Hack to remove text in back button on segued view controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

// TODO refactor out
-(void)getParties {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Parties" ofType:@"json"];
    NSData* jsonData = [NSData dataWithContentsOfFile:path];
    
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    self.data = [[NSMutableArray alloc] init];
    
    if (arrayData.count > 0) {
        
        for (int i = 0; i < arrayData.count; i++) {
            
            NSDictionary* dictTemp = arrayData[i];
            MenuItem* menuItem = [MenuItem initFromDictionary: dictTemp];
            
            [self.data addObject:menuItem];
        }
    }
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

-(void)setTableViewCellStyle:(UICollectionViewCell*)tableViewCell {
    tableViewCell.layer.borderWidth= 1.0f;
    tableViewCell.layer.borderColor= [UIColor whiteColor].CGColor;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* tableViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    UIImageView* imageView = (UIImageView*)[tableViewCell viewWithTag:1];
    imageView.frame = tableViewCell.bounds;
    imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    
    UILabel* textlabel = (UILabel*)[tableViewCell viewWithTag:2];
    
    MenuItem* menuItem = (MenuItem*)self.data[indexPath.row];
   
    textlabel.text = menuItem.name;
    
    [self setTableViewCellStyle:tableViewCell];
    
    return tableViewCell;
}


@end
