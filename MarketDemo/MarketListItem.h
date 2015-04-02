//
//  MarketListItem.h
//  MarketDemo
//
//  Created by Igor Iliyn on 4/1/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MarketListItem : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) UIImage  *image;

@end
