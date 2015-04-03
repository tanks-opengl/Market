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
    
    if (!errorParse)
    {
        for (NSDictionary *item in items)
        {
            MarketListItem *marketItem = [[MarketListItem alloc]init];
            
            marketItem.itemId   = item[@"id"];
            marketItem.name     = item[@"name"];
            marketItem.price    = [item[@"price"] description];
            marketItem.imageURL = item[@"imageURL"];
            
            [array addObject:marketItem];
        }
    } else {
        //Handle error
    }
    
    return array;
}

+ (NSMutableArray *)parseCurrentItem:(NSMutableData *)data
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSError *errorParse;
    
    NSDictionary *item = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&errorParse];
    
    if (!errorParse)
    {
        
        DetailListItem *currentItem = [[DetailListItem alloc]init];
            
        currentItem.itemId             = item[@"id"];
        currentItem.itemName           = item[@"name"];
        currentItem.itemPrice          = item[@"price"];
        currentItem.itemAmount         = item[@"amount"];
        currentItem.itemCategory       = item[@"category"];
        currentItem.itemParentCategory = item[@"parent_category"];
        currentItem.itemImageURL       = item[@"imageURL"];
        
        [array addObject:currentItem];
        
    } else {
        //Handle error
    }
    
    return array;
}

@end
