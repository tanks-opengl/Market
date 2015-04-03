//
//  WatchedTableViewController.m
//  MarketDemo
//
//  Created by Igor Iliyn on 4/2/15.
//  Copyright (c) 2015 aura. All rights reserved.
//

#import "WatchedTableViewController.h"

@interface WatchedTableViewController ()

@property (nonatomic, strong) NSMutableArray *watchedItems;

@end

@implementation WatchedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"Просмотренные";
    self.watchedItems = [NSMutableArray array];
    
    //Register custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listCellIdentifier"];
    [self retrieveItems];
    
}

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


- (void)retrieveItems
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"ListItem"];
    NSError *error;
    self.watchedItems = [[context executeFetchRequest:request error:&error] mutableCopy];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark cell size

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.watchedItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *item = [self.watchedItems objectAtIndex:indexPath.row];
    NSString *s = [item valueForKey:@"name"];
    cell.itemName.text = [item valueForKey:@"name"];
    cell.itemPrice.text = [NSString stringWithFormat:@"Цена\n%@\nгрн",[item valueForKey:@"price"]];
    UIImage *image = [UIImage imageWithData:[item valueForKey:@"image"]];
    cell.itemImage.image = image;
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
