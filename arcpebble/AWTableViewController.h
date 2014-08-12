//
//  AWTableViewController.h
//  arcpebble
//
//  Created by Matthew Roll on 8/11/14.
//  Copyright (c) 2014 arcweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AWTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *jobs;

- (void)getJobs;

@end
