//
//  Parser.m
//  MarketDemo
//
//  Created by Igor Iliyn on 4/2/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "Parser.h"

@implementation Parser

+ (NSMutableArray *)parseListItems:(NSMutableData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSError *errorParse;
    
    NSArray *items = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorParse];
    
    if (!errorParse) {
        for (NSDictionary *item in items) {
            MarketListItem *marketItem = [[MarketListItem alloc]init];
            marketItem.name = item[@"name"];
            marketItem.price = [item[@"price"] description];
            marketItem.imageURL = item[@"imageURL"];
            marketItem.itemId = item[@"id"];
            [array addObject:marketItem];
        }
    }
    
    return array;
}

+ (NSMutableArray *)parseCurrentItem:(NSMutableData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    
    
    return array;
}

@end
