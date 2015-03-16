//
//  PartyPageViewController.h
//  SFBars
//
//  Created by JACKIE TRILLO on 3/15/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "Party.h"

@interface PartyPageViewController : UIViewController

//@property (nonatomic, strong) IBOutlet UILabel* nameLabel;
@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) IBOutlet UILabel* nameLabel;

-(id)initWithParty:(Party*)party;

@end
