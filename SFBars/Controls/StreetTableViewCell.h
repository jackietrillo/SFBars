//
//  StreetTableViewCell.h
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/11/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreetTableViewCell : UITableViewCell
    @property (readonly, nonatomic, strong) IBOutlet UIImageView* imageView;
    @property (readwrite, nonatomic, strong) IBOutlet UILabel* nameLabel;
    @property (readwrite, nonatomic, strong) IBOutlet UILabel* iconLabel;
@end
