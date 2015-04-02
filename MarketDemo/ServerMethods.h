//
//  ServerMethods.h
//  MarketDemo
//
//  Created by Igor Iliyn on 4/2/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerMethods : NSObject

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, copy) void (^completionHandler)(void);

@end
