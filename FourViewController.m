//
//  FourViewController.m
//  new4
//
//  Created by Mihail Poleshchuk on 19.04.17.
//  Copyright (c) 2017 Dev. All rights reserved.
//

#import "FourViewController.h"
#import "DatabaseManager.h"

@implementation FourViewController

#define dataReload @"reload_data"
#define titleEditButton @"Edit"
#define titleDoneButton @"Done"
#define titleTableView @"My Favorites"

@synthesize restaurants = _restaurants;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds]
                                                  style:UITableViewStylePlain];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_data) name:dataReload object:nil];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _editButton = [[UIBarButtonItem alloc] initWithTitle:titleEditButton style:UIBarButtonItemStylePlain
                                                  target:self
                                                  action:@selector(editButton)];
    self.navigationItem.rightBarButtonItem = _editButton;
    
    self.title = titleTableView;

}


-(void)handle_data {
    [self.tableView reloadData];
}


- (void)dealloc
{
    [_editButton release];
    [_tableView release];
    [_restaurants release];
    [_secondViewController release];
    
    [super dealloc];
}


- (IBAction)editButton
{
    if (self.editing)
    {
        [_editButton setTitle:titleEditButton];
        [self setEditing:NO animated:YES];
    }
    else
    {
        [_editButton setTitle:titleDoneButton];
        [self setEditing:YES animated:YES];
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DatabaseManager failedDatabase].myFav.count;
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
    Restaurant *info = [[DatabaseManager failedDatabase].myFav objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:info.logo];
    cell.textLabel.text = info.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _secondViewController = [[[SecondViewController alloc] init] autorelease];
    _secondViewController.restaurant = [[DatabaseManager failedDatabase].myFav objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:_secondViewController animated:YES];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Restaurant *infoDel = [[DatabaseManager failedDatabase].myFav objectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[DatabaseManager failedDatabase].myFav removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
        [[DatabaseManager failedDatabase] saveToUserDefaults];
    }
    [self setEditing:NO animated:YES];
    [[DatabaseManager failedDatabase].forSave removeObject:@(infoDel.uniqId)];
    
    for (Restaurant *info in self.restaurants)
    {
        if (info.uniqId == infoDel.uniqId)
        {
            info.isFav = NO;
        }
    }
    [[DatabaseManager failedDatabase] saveToUserDefaults];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editing)
    {
        [_editButton setTitle:titleDoneButton];
    }
    else
    {
        [_editButton setTitle:titleEditButton];
    }
    return YES;
}


@end
