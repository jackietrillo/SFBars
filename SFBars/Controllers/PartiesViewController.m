//
//  MusicViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/3/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "PartiesViewController.h"

@interface PartiesViewController ()

@property (readwrite, nonatomic, strong) NSArray* partiesData;
@end

@implementation PartiesViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initNavigation];
    
    
    [self.barsGateway getParties: ^(NSArray* data) {
        if (data) {
            self.partiesData = data;
            
            [self.collectionView reloadData];
        }
        self.collectionView.hidden = NO;
        [self hideLoadingIndicator];
    }];

}

-(void)initNavigation {
    
    [self addMenuButtonToNavigation];
    
    self.navigationItem.title = NSLocalizedString(@"PARTIES", @"PARTIES");
    
    // note Hack to remove text in back button on segued view controller
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}


#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.partiesData.count;
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
    
    Party* party = (Party*)self.partiesData[indexPath.row];
   
    textlabel.text = party.name;
    
    [self setTableViewCellStyle:tableViewCell];
    
    return tableViewCell;
}


@end
