//
//  DatabaseManager.m
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//
#import "DatabaseManager.h"
#import "Restaurant.h"
#import "Rest_Category.h"
#import "Item.h"

@implementation DatabaseManager

#define nameOfUserDefaults @"arrayWithFavoritesId"

@synthesize forSave = _forSave;
@synthesize myFav = _myFav;

static DatabaseManager *_database;


+ (DatabaseManager *)failedDatabase
{
    if (_database == nil)
    {
        _database = [[DatabaseManager alloc] init];
    }
    
    return _database;
}


- (void)saveToUserDefaults
{
    [_prefs setObject:_forSave forKey:nameOfUserDefaults];
    [_prefs synchronize];
}


- (instancetype)init
{
    if (self = [super init])
    {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"default"
                                                             ofType:@"db"];
        
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK)
        {
            NSLog(@"Failed to open database!");
        }
    }
    
    return self;
}


- (void)dealloc
{
    _database = nil;
    [_forSave release];
    [_prefs release];
    [_myFav release];
    
    [super dealloc];
}


- (NSArray *)readRestaurants
{
    _myFav = [[NSMutableArray alloc] init];
    _forSave = [[NSMutableArray alloc] init];
    _prefs = [[NSUserDefaults alloc] init];
    
    NSMutableArray *restaurants = [[[NSMutableArray alloc] init] autorelease];
    
    sqlite3_stmt *statement;
    
    // считывание id, name, logo каждого ресторана
    NSMutableArray *restId = [[NSMutableArray alloc] init];
    NSMutableArray *restNames = [[NSMutableArray alloc] init];
    NSMutableArray *restLogos = [[NSMutableArray alloc] init];
    NSMutableArray *restCategories = [[NSMutableArray alloc] init];
    
    NSString *queryIdNameLogo = @"SELECT r.id, r.name, l.file_path AS file_path FROM ch_restaurant r INNER JOIN ch_restaurant_logo l ON r.id = l.restaurant_id";

    if (sqlite3_prepare_v2(_database, [queryIdNameLogo UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSInteger uniqId = sqlite3_column_int(statement, 0);
                char *nameChars = (char *) sqlite3_column_text(statement, 1);
                char *imgChars = (char *) sqlite3_column_text(statement, 2);
                
                NSString *name = [NSString stringWithUTF8String:nameChars];
                NSString *imgPath = [NSString stringWithUTF8String:imgChars];
                
                [restId addObject:[NSNumber numberWithInt:(int)uniqId]];
                [restNames addObject:name];
                [restLogos addObject:imgPath];
                
                name = nil;
                imgPath = nil;
            }
        }
    
    // для каждого id ресторана получаем array категорий
    for (NSInteger i = 0; i < [restId count]; i++)
    {
        NSMutableArray *categoriesId = [[NSMutableArray alloc] init];
        NSMutableArray *categoriesNames = [[NSMutableArray alloc] init];
        NSMutableArray *categoriesItems = [[NSMutableArray alloc] init];
        
        NSString *queryCateg = [NSString stringWithFormat:@"%@%@", @"SELECT DISTINCT i.category_id FROM ch_item i  WHERE i.restaurant_id = ", @([[restId objectAtIndex:i] integerValue])];
        
        if (sqlite3_prepare_v2(_database, [queryCateg UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSInteger uniqeId = sqlite3_column_int(statement, 0);
                NSNumber *uniqId = [NSNumber numberWithInt:(int)uniqeId];
                
                [categoriesId addObject:uniqId];
            }
        }
        
        queryCateg = nil;

        
        for (NSInteger j = 0; j < categoriesId.count; j++)
        {
            queryCateg = [NSString stringWithFormat:@"%@%@", @"SELECT c.name FROM ch_category c WHERE c.id = ", @([[categoriesId objectAtIndex:j] integerValue])];
            
            if (sqlite3_prepare_v2(_database, [queryCateg UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    char *nameChars = (char *)sqlite3_column_text(statement, 0);
                
                    NSString *name = [NSString stringWithUTF8String:nameChars];
                    
                    [categoriesNames addObject:name];
                    
                    name = nil;
                }
            }
            
            queryCateg = nil;
        }

        // получив все категории для конкретного ресторана получим итемы для конкретной категории
        for (NSInteger j = 0; j < [categoriesId count]; j++)
        {
            NSString *queryItem = [NSString stringWithFormat:@"%@%@%@%@", @"SELECT i.id, i.name, i.serving, i.calories, i.total_fat, i.saturated_fat, i.trans_fats, i.cholesterol, i.sodium, i.carbs FROM ch_item i WHERE i.restaurant_id = ", @([[restId objectAtIndex:i ] integerValue]),  @" AND i.category_id = ", @([[categoriesId objectAtIndex:j] integerValue])];
            
            if (sqlite3_prepare_v2(_database, [queryItem UTF8String], -1, &statement, nil) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    int uniqId = sqlite3_column_int(statement, 0);
                    char *nameChars = (char *) sqlite3_column_text(statement, 1);
                    char *servChars = (char *) sqlite3_column_text(statement,2);
                    int calor = sqlite3_column_int(statement, 3);
                    int tfat = sqlite3_column_int(statement, 4);
                    int sfat = sqlite3_column_int(statement, 5);
                    int trfat = sqlite3_column_int(statement, 6);
                    int chol = sqlite3_column_int(statement, 7);
                    int sod = sqlite3_column_int(statement, 8);
                    int carbs = sqlite3_column_int(statement, 9);

                    NSString *name = [NSString stringWithUTF8String:nameChars];
                    NSString *serving = [NSString stringWithUTF8String:servChars];
                    Item *info = [[Item alloc] initWithUniqId:uniqId
                                                         name:name
                                                      serving:serving
                                                     calories:calor
                                                     totalfat:tfat
                                                 saturatedfat:sfat
                                                     transfat:trfat
                                                  cholesterol:chol
                                                       sodium:sod
                                                   carbonates:carbs];
                    
                    [categoriesItems addObject:info];
                    
                    [info release];
                    
                    name = nil;
                    serving = nil;
                }
            }
            
            queryItem = nil;
            
            Rest_Category *catinfo = [[Rest_Category alloc] initWithUniqId:[[categoriesId objectAtIndex:j]integerValue]
                                                                      name:[categoriesNames objectAtIndex:j]
                                                                     items:[NSArray arrayWithArray:categoriesItems]];
            [restCategories addObject:catinfo];
            [catinfo release];
            [categoriesItems removeAllObjects];
        }
        [categoriesId release];
        [categoriesNames release];
        [categoriesItems release];
        
        queryCateg = nil;
        Restaurant *info = [[Restaurant alloc] initWithUniqueId:[[restId objectAtIndex:i] integerValue]
                                                           name:[restNames objectAtIndex:i]
                                                           logo:[restLogos objectAtIndex:i]
                                                     categories:[NSArray arrayWithArray:restCategories]];
        [restaurants addObject:info];
        [info release];
        [restCategories removeAllObjects];
    }
    [restId release];
    [restNames release];
    [restLogos release];
    [restCategories release];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"name"
                                                         ascending:YES
                                                          selector:@selector(caseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sort];
    NSArray *sortedRestaurants = [restaurants sortedArrayUsingDescriptors:sortDescriptors];
    
    [sort release];
    
    
    if ([[_prefs objectForKey:nameOfUserDefaults] count])
    {
        NSMutableArray *favArr = [_prefs objectForKey:nameOfUserDefaults];
        for (Restaurant *info in sortedRestaurants)
        {
            for (NSInteger i = 0; i < [favArr count]; i++)
            {
                if (info.uniqId == [[favArr objectAtIndex:i] integerValue])
                {
                    [_forSave addObject:@(info.uniqId)];
                    info.isFav = YES;
                    [_myFav addObject:info];
                    break;
                }
            }
        }
    }
    return sortedRestaurants;
}


@end
