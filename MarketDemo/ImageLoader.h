//
//  ImageLoader.h
//  MarketDemo
//
//  Created by Igor Iliyn on 3/31/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketListItem.h"

@interface ImageLoader : NSObject

@property (nonatomic, strong) MarketListItem *listItem;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end
