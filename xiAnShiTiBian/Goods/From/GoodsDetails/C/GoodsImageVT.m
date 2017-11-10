//
//  GoodsImageVT.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "GoodsImageVT.h"

@implementation GoodsImageVT
+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSArray class];
}
//返回转换后的对象
- (id)transformedValue:(id)value {
    
    return  value;
}

- (id)reverseTransformedValue:(id)value {
    return [NSArray array];
}

@end
