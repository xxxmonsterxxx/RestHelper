//
//  FirstViewController.h
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface FirstViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
{
    NSArray *_restaurants;
    NSMutableArray *_searchData;
    UITableView *_tableView;
    SecondViewController *_secondViewController;
    UISearchBar *_searchBar;
    UISearchDisplayController *_searchDisplayController;
    NSMutableDictionary *_restDict;
    NSMutableArray *_searchedRestaurants;
}


@property (nonatomic, retain) NSMutableDictionary *restDict;
@property (nonatomic, retain) UISearchDisplayController *searchDisplayController;
@property (nonatomic, retain) NSMutableArray *searchData;
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) SecondViewController *secondViewController;
@property (nonatomic, retain) NSArray *restaurants;


- (instancetype)initWithRestaurants:(NSArray *)rests;


@end
