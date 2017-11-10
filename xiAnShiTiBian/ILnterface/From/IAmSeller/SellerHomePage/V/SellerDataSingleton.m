//
//  SellerDataSingleton.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerDataSingleton.h"

@implementation SellerDataSingleton

+ (SellerDataSingleton *)mainSingleton {
    static SellerDataSingleton *ton = nil;
    if (ton == nil) {
        ton = [[SellerDataSingleton alloc] init];
    }
    return ton;
}

@end
