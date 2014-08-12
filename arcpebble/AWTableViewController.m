//
//  AWTableViewController.m
//  arcpebble
//
//  Created by Matthew Roll on 8/11/14.
//  Copyright (c) 2014 arcweb. All rights reserved.
//

#import "AWTableViewController.h"
#import "AFNetworking/AFHTTPRequestOperationManager.h"

@interface AWTableViewController ()

@end

@implementation AWTableViewController

- (void)getJobs
{
    static NSString * const BaseURLString = @"http://bill.arcweb.co:8080/";
    
    NSString *string = [NSString stringWithFormat:@"%@api/json", BaseURLString];
    
    //NSString *plainAuthString = @"mroll@arcwebtech.com:54b68a7fb6a9cfc5fc54fabe2813cda2";
    //NSData *plainData = [plainAuthString dataUsingEncoding:NSUTF8StringEncoding];
    //NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    //NSString *encodedAuthString = [NSString stringWithFormat:@"Basic %@", base64String];
    
    // 2
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //[manager.requestSerializer setValue:encodedAuthString forHTTPHeaderField:@"Authorization"];
    
    [manager GET:string
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //NSLog(@"JSON: %@", [NSJSONSerialization isValidJSONObject:responseObject] ? @"YES" : @"NO");
             
             
             if( [NSJSONSerialization isValidJSONObject:responseObject] ) {
                 
                 
                self.jobs = [responseObject objectForKey:@"jobs"];
                [self.tableView reloadData];
                 
             } else {
                 
                 NSLog(@"We're good");
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
        
         }];
    
}

- (void)jsonTapped
{
    static NSString * const BaseURLString = @"http://bill.arcweb.co:8080/";
    // 1
    NSString *string = [NSString stringWithFormat:@"%@api/json", BaseURLString];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        
        NSArray *jobArray = [responseObject objectForKey:@"jobs"];
        self.jobs = [[NSMutableArray alloc] init];
        
        for (id object in jobArray) {
            NSString *name = [object objectForKey:@"name"];
            [self.jobs addObject:name];
        }
        
        NSLog(@"%@", self.jobs);
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Jobs"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Initialize table data
    //jobs = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    [self jsonTapped];
    NSLog(@"%@", self.jobs);
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.jobs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"JobCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.jobs objectAtIndex:indexPath.row];
    return cell;
}

@end