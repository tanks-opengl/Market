//
//  DetailViewController.m
//  MarketDemo
//
//  Created by Igor Iliyn on 3/31/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) NSMutableArray *currentItem;

@end

@implementation DetailViewController

- (void)setMarketListItemObject:(MarketListItem *)item
{
    self.marketObject = item;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentItem = [NSMutableArray array];
    
    ServerMethods *server    = [[ServerMethods alloc]init];
    server.complationHandler = ^(NSMutableData *data){
        self.currentItem = [Parser parseCurrentItem:data];
        [self updateViews];
        [self saveItem];
    };
    [server loadCurrentItem:self.marketObject.itemId];
    
}

- (void)updateViews
{
    DetailListItem *item = [self.currentItem firstObject];
    
    self.categoryLabel.text = [NSString stringWithFormat:@"%@ : %@",item.itemParentCategory,item.itemCategory];
    self.nameLabel.text = item.itemName;
    self.amountLabel.text = [NSString stringWithFormat:@"Всего в наличии %@ шт.",item.itemAmount];
    self.priceLabel.text = [NSString stringWithFormat:@"Цена %@ грн.",item.itemPrice];
    
    ImageDownloader *loader = [[ImageDownloader alloc]initWithStringURL:item.itemImageURL];
    loader.completionHandler = ^(NSMutableData *data){
        self.itemImage.image = [UIImage imageWithData:data];
    };
    [loader startDownload];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (void)saveItem
{
    DetailListItem *item = [self.currentItem firstObject];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (context) {
        NSManagedObject *itemModel = [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:context];
        
        [itemModel setValue:[item.itemId stringValue] forKey:@"id"];
        [itemModel setValue:item.itemName forKey:@"name"];
        [itemModel setValue:[item.itemPrice stringValue] forKey:@"price"];
        NSData *imageData = UIImagePNGRepresentation(self.marketObject.image);
        [itemModel setValue:imageData forKey:@"image"];
    
        NSError *error;
        
        if (![context save:&error])
        {
            NSLog(@"Error saving item!!!");
        }
    }
}

@end
