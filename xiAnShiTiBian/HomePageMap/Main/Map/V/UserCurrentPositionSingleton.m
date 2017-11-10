//
//  UserCurrentPositionSingleton.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "UserCurrentPositionSingleton.h"

@implementation UserCurrentPositionSingleton

+ (UserCurrentPositionSingleton *)mainSingleton {
    static UserCurrentPositionSingleton *ton = nil;
    if (ton == nil) {
        ton = [[UserCurrentPositionSingleton alloc] init];
    }
    return ton;
}

@end
