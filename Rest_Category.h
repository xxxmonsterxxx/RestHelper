//
//  Category.h
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rest_Category : NSObject
{
    NSInteger _uniqId;
    NSString *_name;
    NSArray *_items;
}


@property (nonatomic) NSInteger uniqId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *items;


- (instancetype)initWithUniqId:(NSInteger)uniqId name:(NSString *)name items:(NSArray *)items;


@end
