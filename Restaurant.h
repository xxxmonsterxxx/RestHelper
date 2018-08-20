//
//  Restaurant.h
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
{
    NSInteger _uniqId;
    NSString *_name;
    NSString *_logo;
    NSArray *_categories;
    BOOL _isFav;
}


@property (nonatomic) NSInteger uniqId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSArray *categories;
@property (nonatomic) BOOL isFav;


- (instancetype)initWithUniqueId:(NSInteger)uniqId
                          name:(NSString *)name
                          logo:(NSString *)logo
                    categories:(NSArray *)categories;


@end
