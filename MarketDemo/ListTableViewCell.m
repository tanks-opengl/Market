//
//  ListTableViewCell.m
//  MarketDemo
//
//  Created by Igor Iliyn on 3/31/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.itemImage.layer.masksToBounds = YES;
    self.itemImage.layer.cornerRadius = 45;// make image rounded
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *) reuseIdentifier {
    return @"listCellIdentifier";
}

@end
