//
//  ListTableViewCell.m
//  MarketDemo
//
//  Created by Igor Iliyn on 3/31/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.itemImage.layer.cornerRadius = self.itemImage.frame.size.width / 2;
    self.itemImage.clipsToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSString *) reuseIdentifier
{
    return @"listCellIdentifier";
}

@end
