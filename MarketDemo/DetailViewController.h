//
//  DetailViewController.h
//  MarketDemo
//
//  Created by Igor Iliyn on 3/31/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerMethods.h"
#import "Parser.h"
#import "ImageDownloader.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) NSString *itemID;

- (void)setItemIdentifier:(NSString *)item;

@end
