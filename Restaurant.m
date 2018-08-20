//
//  Restaurant.m
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

@synthesize uniqId = _uniqId;
@synthesize name = _name;
@synthesize logo = _logo;
@synthesize categories = _categories;
@synthesize isFav = _isFav;


- (instancetype)initWithUniqueId:(NSInteger)uniqId name:(NSString *)name logo:(NSString *)logo categories:(NSArray *)categories
{
    self = [super init];
    
    if (self != nil)
    {
        self.uniqId = uniqId;
        self.name = [NSString stringWithString:name];
        self.logo = [NSString stringWithString:logo];
        self.categories = [NSArray arrayWithArray:categories];
        self.isFav = NO;
    }
    
    return self;
}


- (void)dealloc
{
    self.name = nil;
    self.logo = nil;
    self.categories = nil;
    
    [super dealloc];
}


@end
