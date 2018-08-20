//
//  ThirdViewController.h
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface ThirdViewController : UITableViewController
{
    Item *_item;
    UITableView *_tableView;
}

@property (nonatomic, strong) Item *item;

@end
