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
        
        //NSLog(@"%@", self.jobs);
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
    
    [self getJobs];
    //NSLog(@"%@", self.jobs);
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