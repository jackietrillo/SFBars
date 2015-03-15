//
//  BarTableViewCell.h
//  
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarViewTableViewCell : UITableViewCell

@property (readwrite, nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (readwrite, nonatomic, weak) IBOutlet UILabel* descripLabel;
@property (readwrite, nonatomic, weak) IBOutlet UILabel* addressLabel;
@property (readwrite, nonatomic, weak) IBOutlet UILabel* hoursLabel;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* mapButton;
@property (readwrite, nonatomic, weak) IBOutlet UIImageView* logo;
@property (readwrite, nonatomic, weak) IBOutlet UIButton* websiteButton;

@end
