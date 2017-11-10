//
//  BuyersOrderGoodsModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/30.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "BuyersOrderGoodsModel+CoreDataProperties.h"

@implementation BuyersOrderGoodsModel (CoreDataProperties)

+ (NSFetchRequest<BuyersOrderGoodsModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BuyersOrderGoodsModel"];
}

@dynamic goodsId;
@dynamic goodsImage;
@dynamic goodsName;
@dynamic goodsNum;
@dynamic goodsPrice;
@dynamic specInfo;
- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
