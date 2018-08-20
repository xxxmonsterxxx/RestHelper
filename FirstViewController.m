//
//  FirstViewController.m
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController

#define alpha @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define titleFirstViewTable @"Restaurants"

@synthesize searchData = _searchData;
@synthesize searchDisplayController = _searchDisplayController;
@synthesize searchBar = _searchBar;
@synthesize restaurants = _restaurants;
@synthesize secondViewController = _secondViewController;
@synthesize restDict = _restDict;


- (instancetype)initWithRestaurants:(NSArray *)rests
{
    self.restaurants = rests;
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _restDict = [[NSMutableDictionary alloc] init];
    _searchData = [[NSMutableArray alloc] init];

    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    [_searchBar sizeToFit];
    _searchDisplayController = [[UISearchDisplayController alloc]  initWithSearchBar:self.searchBar contentsController:self];
    _searchDisplayController.delegate = self;
    _searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.title = titleFirstViewTable;
}


- (void)dealloc
{
    [_restaurants release];
    [_tableView release];
    [_searchData release];
    [_secondViewController release];
    [_searchDisplayController release];
    [_restDict release];
    [_searchedRestaurants release];
    
    [super dealloc];
}



#pragma mark - SearchDisplayController

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self.searchData removeAllObjects];
    
    for (Restaurant *info in self.restaurants)
    {
        if ([info.name rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            [self.searchData addObject:info];
        }
    }
    [self.tableView reloadData];
    return YES;
}



#pragma mark - SearchBar

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:NO animated:NO];
    self.searchBar.text = @"";
    [self.searchBar endEditing:YES];
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.searchBar setShowsCancelButton:YES animated:NO];
    return YES;
}



#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Choose restaurant";
}


-(NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if(self.searchBar.text.length == 0)
        return self.restaurants.count;
    else
        return self.searchData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell =
    [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    
    Restaurant *info = nil;
    
    if(self.searchBar.text.length == 0)
        info = [self.restaurants objectAtIndex:indexPath.row];
    else
        info = [self.searchData objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:info.logo];
    cell.textLabel.text = info.name;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _secondViewController = [[SecondViewController alloc] init];
    Restaurant *info = nil;
    if (self.searchBar.text.length == 0)
        info = [self.restaurants objectAtIndex:indexPath.row];
    else
        info = [self.searchData objectAtIndex:indexPath.row];
    self.secondViewController.restaurant = info;
    [self.navigationController pushViewController:_secondViewController animated:YES];
}


- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    [_restDict removeAllObjects];
    _searchedRestaurants = [[[NSMutableArray alloc] init] autorelease];
    
    if (self.searchBar.text.length == 0)
    {
        _searchedRestaurants = [NSMutableArray arrayWithArray:self.restaurants];
    }
    else
    {
        _searchedRestaurants = [NSMutableArray arrayWithArray:self.searchData];
    }

    NSString *alphabet = [[[NSString alloc] initWithString:alpha] autorelease];

    
    for (Restaurant *info in _searchedRestaurants)
    {
        for (NSInteger x = 0; x < 26; x++)
        {
            NSString *firstLetter = [alphabet substringWithRange:NSMakeRange(x, 1)];
            if ([[info.name substringToIndex:1] isEqualToString:firstLetter])
            {
                [self.restDict setObject:info.name forKey:firstLetter];
                break;
            }
        }
    }

    NSArray *sortedKeys = [_restDict.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    return sortedKeys;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    _searchedRestaurants = [[[NSMutableArray alloc] init] autorelease];
    
    if (self.searchBar.text.length == 0)
    {
        _searchedRestaurants = [NSMutableArray arrayWithArray:self.restaurants];
    }
    else
    {
        _searchedRestaurants = [NSMutableArray arrayWithArray:self.searchData];
    }
    
    NSInteger rest_index = -1;
    NSString *restTargetName = [[[NSString alloc] init] autorelease];
    for (NSString *key in self.restDict.allKeys)
    {
        if ([title isEqualToString:key])
        {
            restTargetName = [self.restDict objectForKey:key];
            break;
        }
    }
    for (Restaurant *info in _searchedRestaurants)
    {
        rest_index++;
        if ([info.name isEqualToString:restTargetName])
        {
            break;
        }
    }

    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rest_index inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    return -1;
}


@end
