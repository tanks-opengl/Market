//
//  Parser.h
//  MarketDemo
//
//  Created by Igor Iliyn on 4/2/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketListItem.h"
#import "DetailListItem.h"

@interface Parser : NSObject

+ (NSMutableArray *)parseListItems:(NSMutableData *)data;
+ (NSMutableArray *)parseCurrentItem:(NSMutableData *)data;

@end
