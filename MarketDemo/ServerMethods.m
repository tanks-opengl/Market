//
//  ServerMethods.m
//  MarketDemo
//
//  Created by Igor Iliyn on 4/2/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "ServerMethods.h"
#import <UIKit/UIKit.h>

#define LIST_ITEMS_URL   @"http://toit.hol.es/basic/web/index.php?r=site/list"
#define CURRENT_ITEM_URL @"http://toit.hol.es/basic/web/index.php?r=site/current-item&itemId="

@interface ServerMethods()

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData   *data;
@property int code;

@end
    
@implementation ServerMethods

- (void)loadListItems
{    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:LIST_ITEMS_URL]];
    self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

- (void)loadCurrentItem
{
    
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    self.code = (int)[httpResponse statusCode];
    self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.connection = nil;
    self.data = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@",[[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    switch (self.code) {
        case 200:
            if (self.complationHandler) {
                self.complationHandler(self.data);
            }
            break;
            
        default:
            
            break;
    }
    
}

@end
