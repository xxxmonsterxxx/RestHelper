//
//  Item.h
//  new4
//
//  Created by Dev on 15/04/2017.
//  Copyright © 2017 Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject
{
    NSInteger _uniqId;
    NSString *_name;
    NSString *_serves;
    NSInteger _calories;
    NSInteger _totalFat;
    NSInteger _saturatedFat;
    NSInteger _transFat;
    NSInteger _cholesterol;
    NSInteger _sodium;
    NSInteger _carbs;
}


@property (nonatomic) NSInteger uniqId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *serves;
@property (nonatomic) NSInteger calories;
@property (nonatomic) NSInteger totalFat;
@property (nonatomic) NSInteger saturatedFat;
@property (nonatomic) NSInteger transFat;
@property (nonatomic) NSInteger cholesterol;
@property (nonatomic) NSInteger sodium;
@property (nonatomic) NSInteger carbs;


- (instancetype)initWithUniqId:(NSInteger)uniqId
                          name:(NSString *)name
                       serving:(NSString *)serv
                      calories:(NSInteger)cal
                      totalfat:(NSInteger)fat
                  saturatedfat:(NSInteger)sfat
                      transfat:(NSInteger)tfat
                   cholesterol:(NSInteger)chol
                        sodium:(NSInteger)sod
                    carbonates:(NSInteger)car;


@end
