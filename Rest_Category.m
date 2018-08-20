//
//  Category.m
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "Rest_Category.h"

@implementation Rest_Category

@synthesize uniqId = _uniqId;
@synthesize name = _name;
@synthesize items = _items;


- (instancetype)initWithUniqId:(NSInteger)uniqId name:(NSString *)name items:(NSArray *)items
{
    if (self = [super init])
    {
        self.uniqId = uniqId;
        self.name = name;
        self.items = [NSArray arrayWithArray:items];
    }
    
    return self;
}


- (void)dealloc
{
    self.name = nil;
    self.items = nil;
    
    [super dealloc];
}


@end
