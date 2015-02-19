//
//  MusicViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 2/3/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "MusicViewController.h"

@interface MusicViewController ()

@property (readwrite, nonatomic, strong) NSMutableArray* data;
@end

@implementation MusicViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadData];
}

-(void)initNavigation {
    //menu button
    UIBarButtonItem* menuButton = [[UIBarButtonItem alloc] init];
    
    UIFont* font = [UIFont fontWithName:@"GLYPHICONSHalflings-Regular" size:25.0];
    NSDictionary* attributesNormal =  @{ NSFontAttributeName: font};
    
    [menuButton setTitleTextAttributes:attributesNormal forState:UIControlStateNormal];
    [menuButton setTitle:[NSString stringWithUTF8String:"\ue012"]];
    
    [menuButton setTarget:self];
    [menuButton setAction:@selector(showMenu:)];
    
    self.navigationItem.leftBarButtonItem = menuButton;
    self.navigationItem.title = @"MUSIC"; //TODO: Localize
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)loadData {
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"MusicTypes" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:path];
    
    [self parseData:data];
    
    data = nil;
}

-(void)parseData: (NSData*)jsonData {
    
    NSError* errorData;
    NSArray* arrayData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&errorData];
    
    if (errorData != nil) {
        //TODO: log error
        //TODO: alert User
    }
    
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

-(void)setCellStyle:(UICollectionViewCell*)cell {
    cell.layer.borderWidth=1.0f;
    cell.layer.borderColor=[UIColor whiteColor].CGColor;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView* imageView = (UIImageView*)[cell viewWithTag:1];
    imageView.frame = cell.bounds;
    imageView.image = [UIImage imageNamed:@"DefaultImage-Bar"];
    
    UILabel* textlabel = (UILabel*)[cell viewWithTag:2];
    
    MenuItem* menuItem = (MenuItem*)self.data[indexPath.row];
    textlabel.text = menuItem.name;
    
    [self setCellStyle:cell];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
}

- (void)showMenu:(id)sender {
 
 [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
