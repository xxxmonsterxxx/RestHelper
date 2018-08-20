//
//  SecondViewController.m
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "SecondViewController.h"
#import "Rest_Category.h"
#import "Item.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "DatabaseManager.h"

@implementation SecondViewController

#define favoritesSound @"fav_sound"
#define isFavCheck @"isFavCheck"
#define favoritesButtonImage @"heart.png"
#define favoritesPushedButtonImage @"heart_fill.png"
#define dataReload @"reload_data"
#define notificationName @"isFavCheck"
#define titleFirstNavController @"Restaurants"
#define titleSecondNavController @"My favorites"

@synthesize restDictionary = _restDictionary;


- (void)viewDidLoad
{
    [super viewDidLoad];

    _buttonURL= [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:favoritesSound ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)_buttonURL, &_soundID );
    
    _restDictionary = [[NSMutableDictionary alloc] init];
    for (Rest_Category *cat in _restaurant.categories)
    {
        [self.restDictionary setObject:cat.items forKey:cat.name];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fav_check) name:isFavCheck object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self fav_check];

}


- (IBAction) addTofav
{
    if (self.restaurant.isFav)
    {
        self.restaurant.isFav = NO;
        [[DatabaseManager failedDatabase].myFav removeObject:self.restaurant];
        [_addToFav setImage:[UIImage imageNamed:favoritesButtonImage]];
        [[DatabaseManager failedDatabase].forSave removeObject:@(self.restaurant.uniqId)];
        [[NSNotificationCenter defaultCenter] postNotificationName:dataReload object:self];
    }
    else
    {
        AudioServicesPlaySystemSound(_soundID);
        self.restaurant.isFav = YES;
        [[DatabaseManager failedDatabase].myFav addObject:self.restaurant];
        [_addToFav setImage:[UIImage imageNamed:favoritesPushedButtonImage]];
        [[DatabaseManager failedDatabase].forSave addObject:@(self.restaurant.uniqId)];
        [[NSNotificationCenter defaultCenter] postNotificationName:dataReload object:self];
    }
    [[DatabaseManager failedDatabase] saveToUserDefaults];
}


-(void)fav_check
{
    
    if (_restaurant.isFav)
    {
        _addToFav = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:favoritesPushedButtonImage] style:(NSInteger)UIBarStyleDefault target:self action:@selector(addTofav)];
    }
    else
    {
        _addToFav = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:favoritesButtonImage] style:(NSInteger)UIBarStyleDefault target:self action:@selector(addTofav)];
    }
    self.navigationItem.rightBarButtonItem = _addToFav;
}



#pragma mark - TableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return [self.restDictionary count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.restDictionary objectForKey:[self.restDictionary.allKeys objectAtIndex:section]] count];
}


- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.restDictionary.allKeys objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:cellIdentifier] autorelease];
    }
    NSString *sectionName = self.restDictionary.allKeys[indexPath.section];
    NSMutableArray *items = [self.restDictionary objectForKey:sectionName];
    Item *item = [items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    ThirdViewController *thirdViewController = [[[ThirdViewController alloc] init] autorelease];
    NSString *selectedSection = self.restDictionary.allKeys[indexPath.section];
    NSMutableArray *items = [self.restDictionary objectForKey:selectedSection];
    Item *item = [items objectAtIndex:indexPath.row];
    thirdViewController.item = item;
    [self.navigationController pushViewController:thirdViewController animated:YES];
}


- (void)dealloc
{
    [_addToFav release];
    [_restaurant release];
    [_tableView release];
    [_restDictionary release];
    [_buttonURL release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

@end
