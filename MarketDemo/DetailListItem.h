//
//  DetailListItem.h
//  MarketDemo
//
//  Created by Igor Iliyn on 3/31/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailListItem : NSObject

@property (strong, nonatomic) NSNumber *itemId;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSNumber *itemPrice;
@property (strong, nonatomic) NSNumber *itemAmount;
@property (strong, nonatomic) NSString *itemCategory;
@property (strong, nonatomic) NSString *itemParentCategory;
@property (strong, nonatomic) NSString *itemImageURL;

@end
