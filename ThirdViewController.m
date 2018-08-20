//
//  ThirdViewController.m
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController

@synthesize item = _item;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    self.title = @"Items";
}

- (void)dealloc
{
    [_tableView release];
    
    [super dealloc];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}


- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"Name";
        cell.detailTextLabel.text = self.item.name;
    }
    if (indexPath.row == 1)
    {
        cell.textLabel.text = @"Serving";
        cell.detailTextLabel.text = self.item.serves;
    }
    if (indexPath.row == 2)
    {
        cell.textLabel.text = @"Calories";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(self.item.calories)];
    }
    if (indexPath.row == 3)
    {
        cell.textLabel.text = @"Total fat";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(self.item.totalFat)];
    }
    if (indexPath.row == 4)
    {
        cell.textLabel.text = @"Saturated fat";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(self.item.saturatedFat)];
    }
    if (indexPath.row == 5)
    {
        cell.textLabel.text = @"Trans fat";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(self.item.transFat)];
    }
    if (indexPath.row == 6)
    {
        cell.textLabel.text = @"Cholesterol";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(self.item.cholesterol)];
    }
    if (indexPath.row == 7)
    {
        cell.textLabel.text = @"Sodium";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",@(self.item.sodium)];
    }

    return cell;
}


@end
