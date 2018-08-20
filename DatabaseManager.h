//
//  DatabaseManager.h
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DatabaseManager : NSObject
{
    sqlite3 *_database;
    NSMutableArray *_forSave;
    NSMutableArray *_myFav;
    NSUserDefaults *_prefs;
}


@property (nonatomic, assign) NSMutableArray *forSave;
@property (nonatomic, retain) NSMutableArray *myFav;


+ (DatabaseManager *)failedDatabase;
- (NSMutableArray *)readRestaurants;
- (void)saveToUserDefaults;


@end
