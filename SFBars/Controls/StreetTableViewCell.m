//
//  StreetTableViewCell.m
//  SanFranciscoStreets
//
//  Created by JACKIE TRILLO on 11/11/14.
//  Copyright (c) 2014 JACKIE TRILLO. All rights reserved.
//

#import "StreetTableViewCell.h"


@interface StreetTableViewCell()
{
    //private
}

//properties


@end

@implementation StreetTableViewCell

- (void)awakeFromNib {
    
   // UIView *selectionColor = [[UIView alloc] init];
    //UIColor* color = [self colorWithRGBHex:0x000000];
    //selectionColor.backgroundColor = color;
    //bself.selectedBackgroundView = selectionColor;
    
    [self.iconLabel setText:[NSString stringWithUTF8String:"\uf000"]];
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
