
//
//  goodsSpecValueTransformer.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "goodsSpecValueTransformer.h"

@implementation goodsSpecValueTransformer
+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSDictionary class];
}
//返回转换后的对象
- (id)transformedValue:(id)value {
    
    return  value;
}

- (id)reverseTransformedValue:(id)value {
    return [NSDictionary dictionary];
}

@end
