//
//  ServerMethods.h
//  MarketDemo
//
//  Created by Igor Iliyn on 4/2/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerMethods : NSObject

@property (nonatomic, strong) void (^complationHandler)(NSMutableData *);

- (void)loadListItems;
- (void)loadCurrentItem;

@end
