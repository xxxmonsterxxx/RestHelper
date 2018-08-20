//
//  AppDelegate.m
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseManager.h"

@implementation AppDelegate

#define restaurantsImage @"restaurants.png"
#define myFavoritesImage @"star-7.png"
#define restaurantsNavigationBar @"res_navigation_bar.png"
#define favoritesNavigationBar @"fav_navigation_bar.png"
#define notificationName @"isFavCheck"
#define titleFirstNavController @"Restaurants"
#define titleSecondNavController @"My favorites"

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _restaurants = [DatabaseManager failedDatabase].readRestaurants;
    
        
    
    _firstViewController = [[FirstViewController alloc] initWithRestaurants:_restaurants];
    _fourViewController = [[FourViewController alloc] init];
    _fourViewController.restaurants = _restaurants;
    
    _navController1 = [[UINavigationController alloc] initWithRootViewController:_firstViewController];
    _navController1.tabBarItem = [[[UITabBarItem alloc] initWithTitle:titleFirstNavController
                                                               image:[UIImage imageNamed:restaurantsImage]
                                                                 tag:1] autorelease];
    [_navController1.navigationBar setBackgroundImage:[UIImage imageNamed:restaurantsNavigationBar]
                                        forBarMetrics:UIBarMetricsDefault];
    
    _navController2 = [[UINavigationController alloc] initWithRootViewController:_fourViewController];
    _navController2.tabBarItem = [[[UITabBarItem alloc] initWithTitle:titleSecondNavController
                                                               image:[UIImage imageNamed:myFavoritesImage]
                                                                 tag:2] autorelease];
    [_navController2.navigationBar setBackgroundImage:[UIImage imageNamed:favoritesNavigationBar]
                                        forBarMetrics:UIBarMetricsDefault];
    
    NSArray *rootViewControllers = [[[NSArray alloc] initWithObjects:_navController1, _navController2, nil] autorelease];
    
    _tabBar = [[UITabBarController alloc] init];
    _tabBar.viewControllers = rootViewControllers;
    _tabBar.delegate=self;
    
    self.window.rootViewController = _tabBar;

    [self.window addSubview:_tabBar.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)dealloc
{
    [_window release];
    [_tabBar release];
    [_navController1 release];
    [_navController1.tabBarItem release];
    [_navController1.navigationBar release];
    [_navController2 release];
    [_navController2.tabBarItem release];
    [_navController2.navigationBar release];
    [_restaurants release];
    [_firstViewController release];
    [_fourViewController release];
    
    [super dealloc];
}



#pragma mark TabBarController - delegate

- (void)tabBarController:(UITabBarController *)tabBarController
  didSelectViewController:(UIViewController *)viewController
{
    if (_tabBar.selectedIndex == 1)
    {
        [_fourViewController.tableView reloadData];
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
    }
    if (_tabBar.selectedIndex == 0)
    {
        [_firstViewController.tableView reloadData];
        [_firstViewController.secondViewController viewDidLoad];
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory
{
    // The directory the application uses to store the Core Data store file. This code uses a directory named "-56.new4" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


- (NSManagedObjectModel *)managedObjectModel
{
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"new4" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"new4.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext
{
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator)
    {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}



#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
