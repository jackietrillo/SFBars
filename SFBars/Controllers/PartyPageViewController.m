//
//  PartyPageViewController.m
//  SFBars
//
//  Created by JACKIE TRILLO on 3/15/15.
//  Copyright (c) 2015 JACKIE TRILLO. All rights reserved.
//

#import "PartyPageViewController.h"

@interface PartyPageViewController ()

@property (assign) NSInteger pageNumber;
@property (readwrite, nonatomic, strong) Party* party;
@end

@implementation PartyPageViewController

- (id)initWithParty:(Party *)party {
    if (self = [super initWithNibName:@"PartyPageView" bundle:[NSBundle mainBundle]]) {
        self.party = party;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.party.name;
    self.imageView.image = self.party.icon;
}
@end
