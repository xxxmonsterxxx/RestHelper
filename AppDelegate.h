//
//  AppDelegate.h
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FirstViewController.h"
#import "FourViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UITabBarDelegate>
{
    UIWindow *_window;
    UITabBarController *_tabBar;
    UINavigationController *_navController1;
    UINavigationController *_navController2;
    NSArray *_restaurants;
    FirstViewController *_firstViewController;
    FourViewController *_fourViewController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

