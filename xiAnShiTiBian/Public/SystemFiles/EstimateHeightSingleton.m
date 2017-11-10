//
//  EstimateHeightSingleton.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/21.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "EstimateHeightSingleton.h"

@implementation EstimateHeightSingleton
+ (EstimateHeightSingleton *)mainSingleton {
    static EstimateHeightSingleton *ton = nil;
    if (ton == nil) {
        ton = [[EstimateHeightSingleton alloc] init];
    }
    return ton;
}
@end
