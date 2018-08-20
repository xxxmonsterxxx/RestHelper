//
//  FourViewController.h
//  new4
//
//  Created by Mihail Poleshchuk on 19.04.17.
//  Copyright (c) 2017 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "SecondViewController.h"

@interface FourViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    UIBarButtonItem *_editButton;
    UITableView *_tableView;
    NSArray *_restaurants;
    SecondViewController *_secondViewController;
}


@property (nonatomic, retain) NSArray *restaurants;


@end
