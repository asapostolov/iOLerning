//
//  RestaurantOrdersController.m
//  iRestaurant
//
//  Created by Apostol Apostolov on 1/16/14.
//  Copyright (c) 2014 Apostol Apostolov. All rights reserved.
//

#import "RestaurantOrdersController.h"

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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Order Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *order = self.orders[indexPath.row];
    
    cell.textLabel.text = [order valueForKey:@"Customer"];
    cell.detailTextLabel.text =[NSString stringWithFormat: @"%d", [order valueForKey:@"OrderID"]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
