//
//  Item.m
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import "Item.h"

@implementation Item

@synthesize uniqId = _uniqId;
@synthesize name = _name;
@synthesize serves = _serves;
@synthesize calories = _calories;
@synthesize totalFat = _totalFat;
@synthesize saturatedFat = _saturatedFat;
@synthesize transFat = _transFat;
@synthesize cholesterol = _cholesterol;
@synthesize sodium = _sodium;


- (instancetype)initWithUniqId:(NSInteger)uniqId
                          name:(NSString *)name
                       serving:(NSString *)serv
                      calories:(NSInteger)cal
                      totalfat:(NSInteger)fat
                  saturatedfat:(NSInteger)sfat
                      transfat:(NSInteger)tfat
                   cholesterol:(NSInteger)chol
                        sodium:(NSInteger)sod
                    carbonates:(NSInteger)car
{
        if (self = [super init])
        {
            self.uniqId = uniqId;
            self.name = [NSString stringWithString:name];
            self.serves = [NSString stringWithString:serv];
            self.calories = cal;
            self.totalFat = fat;
            self.saturatedFat = sfat;
            self.transFat = tfat;
            self.cholesterol = chol;
            self.sodium = sod;
            self.carbs = car;
        }
    
        return self;
}


- (void)dealloc
{
    self.name = nil;
    self.serves = nil;
    
    [super dealloc];
}


@end
