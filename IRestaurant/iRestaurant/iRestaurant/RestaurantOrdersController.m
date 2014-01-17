//
//  RestaurantOrdersController.m
//  iRestaurant
//
//  Created by Apostol Apostolov on 1/16/14.
//  Copyright (c) 2014 Apostol Apostolov. All rights reserved.
//

#import "RestaurantOrdersController.h"
#import "WebViewController.h"

@interface RestaurantOrdersController ()

@end

@implementation RestaurantOrdersController

-(void) setOrders:(NSArray *)orders
{
    _orders = orders;
    
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self fetchOrders];
}

- (IBAction) fetchOrders{
    [self.refreshControl beginRefreshing];
    NSURL *url = [NSURL URLWithString:[@"http://192.168.15.107:7575/MobileData/GetOrders/445"
                                       stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
   dispatch_queue_t fetchQ= dispatch_queue_create("orders fetcher", NULL);
   dispatch_async(fetchQ
        , ^{
            NSError* error = nil;
            NSData *jsonResults = [NSData dataWithContentsOfURL:url];
            NSArray *orders = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                        options:0
                                                                          error:&error];
            if (error) {
                NSLog(@"%@", [error localizedDescription]);
            } else {
                NSLog(@"Data has loaded successfully.");
            }
            NSLog(@"Order results = %@", orders);
    
            //NSArray  *orders = [propertyListResults allValues];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.refreshControl endRefreshing];
                    self.orders = orders;
                });
        });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Order Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *order = self.orders[indexPath.row];
    
    cell.textLabel.text = [order valueForKey:@"Customer"];
    cell.detailTextLabel.text =[NSString stringWithFormat: @"%d", [order valueForKey:@"OrderID"]];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id detail = self.splitViewController.viewControllers[1];
    
    if([detail isKindOfClass:[UINavigationController class]]){
        detail = [((UINavigationController *) detail).viewControllers firstObject];
    }
    if([detail isKindOfClass:[WebViewController class]]){
        [self prepareWebView:detail toDisplayOrder:self.orders[indexPath.row]];
    }
}

-(void) prepareWebView:(WebViewController *) controller
        toDisplayOrder:(NSDictionary *) order {
    
    //[controller loadUrl:[order valueForKey:@"RestaurantReceiptUrl"  ]];
    controller.loadUrl = [order valueForKey:@"RestaurantReceiptUrl"];
    controller.title = [NSString stringWithFormat:@"Order - %d",
                        [order valueForKey:@"OrderID"]];
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([sender isKindOfClass:[UITableViewCell class]]){
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if(indexPath){
            if([segue.identifier isEqualToString:@"Display Order"]){
                //id detail = segue.destinationViewController;
                //if([detail isKindOfClass:[UINavigationController class]]){
                //    detail = [((UINavigationController *) detail).viewControllers firstObject];
                //}
                if([segue.destinationViewController isKindOfClass:[WebViewController class]]){
                    
                    [self prepareWebView:segue.destinationViewController
                          toDisplayOrder:self.orders[indexPath.row]];
                }
            }
        }
    }
    
}











@end
