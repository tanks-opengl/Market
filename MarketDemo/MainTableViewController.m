//
//  MainTableViewController.m
//  MarketDemo
//
//  Created by Igor Iliyn on 3/30/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "MainTableViewController.h"
#import "DetailViewController.h"
#import "ListTableViewCell.h"
#import "ImageLoader.h"
#import "ListTableViewCell.h"

@interface MainTableViewController ()

@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;

@end

@implementation MainTableViewController

#pragma mark cell size

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Register custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listCellIdentifier"];
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    self.listItems                = [NSMutableArray array];
    
    ServerMethods *server    = [[ServerMethods alloc]init];
    server.complationHandler = ^(NSMutableData *data){
        self.listItems = [Parser parseListItems:data];
        [self.tableView reloadData];
    };
    [server loadListItems];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSUInteger count = self.listItems.count;
    
    if (count == 0)
    {
        return 1;
    }
    return count;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = nil;
    
    NSUInteger nodeCount = self.listItems.count;
    
    if (nodeCount == 0 && indexPath.row == 0)
    {
        // add a placeholder cell while waiting on table data
        cell = [tableView dequeueReusableCellWithIdentifier:@"listCellIdentifier" forIndexPath:indexPath];
        cell.itemImage.image = nil;
        cell.itemName.text = @"Loading…";
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"listCellIdentifier" forIndexPath:indexPath];
        
        // Leave cells empty if there's no data yet
        if (nodeCount > 0)
        {
            // Set up the cell representing the app
            MarketListItem *item = (self.listItems)[indexPath.row];
            
            cell.itemName.text = item.name;
            cell.itemPrice.text = [NSString stringWithFormat:@"Цена\n%@\nгрн",item.price];
            
            // Only load cached images; defer new downloads until scrolling ends
            if (!item.image)
            {
                if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
                {
                    [self startIconDownload:item forIndexPath:indexPath];
                }
                // if a download is deferred or in progress, return a placeholder image
                cell.itemImage.image = [UIImage imageNamed:@"stub.jpeg"];
            }
            else
            {
                cell.itemImage.image = item.image;
            }
        }
    }
    
    return cell;

}

#pragma mark - Table cell image support

- (void)startIconDownload:(MarketListItem *)record forIndexPath:(NSIndexPath *)indexPath
{
    ImageLoader *imageLoader = (self.imageDownloadsInProgress)[indexPath];
    if (imageLoader == nil)
    {
        imageLoader = [[ImageLoader alloc] init];
        imageLoader.listItem = record;
        [imageLoader setCompletionHandler:^{
            
            ListTableViewCell *cell = (ListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            
            // Display the newly loaded image
            cell.itemImage.image = record.image;
            
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
            
        }];
        (self.imageDownloadsInProgress)[indexPath] = imageLoader;
        [imageLoader startDownload];
    }
}

- (void)loadImagesForOnscreenRows
{
    if (self.listItems.count > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            MarketListItem *item = (self.listItems)[indexPath.row];
            
            if (!item.image)
                // Avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:item forIndexPath:indexPath];
            }
        }
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([[segue identifier] isEqualToString:@"detailSegue"])
    {
        NSUInteger selectedRow = [[self.tableView indexPathForSelectedRow] row];
        MarketListItem *item = [self.listItems objectAtIndex:selectedRow];
        [[segue destinationViewController] setMarketListItemObject:item];
    }
   
}


@end
