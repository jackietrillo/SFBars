//
//  BarTableViewCell.m
//  
//
//  Created by JACKIE TRILLO on 11/26/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "BarViewTableViewCell.h"

@implementation BarViewTableViewCell

- (void)awakeFromNib {
  
    UIView *selectedBackgroundView = [[UIView alloc] init];
    UIColor* color = [self colorWithRGBHex:0xcccccc];
    selectedBackgroundView.backgroundColor = color;
    self.selectedBackgroundView = selectedBackgroundView;

    [self.mapButton setTitle:[NSString stringWithUTF8String:"\uf041"] forState:UIControlStateNormal];
    [self.websiteButton setTitle:[NSString stringWithUTF8String:"\uf073"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
@end
