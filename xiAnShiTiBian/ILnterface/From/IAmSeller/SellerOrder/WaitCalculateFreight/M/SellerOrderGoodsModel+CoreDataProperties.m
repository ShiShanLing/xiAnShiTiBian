//
//  SellerOrderGoodsModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerOrderGoodsModel+CoreDataProperties.h"

@implementation SellerOrderGoodsModel (CoreDataProperties)

+ (NSFetchRequest<SellerOrderGoodsModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SellerOrderGoodsModel"];
}

@dynamic buyerId;
@dynamic gcId;
@dynamic goodsId;
@dynamic goodsImage;
@dynamic goodsName;
@dynamic goodsNum;
@dynamic goodsPayPrice;
@dynamic goodsPrice;
@dynamic orderId;
@dynamic recId;
@dynamic specId;
@dynamic specInfo;
@dynamic storeId;
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"goodsNum"]) {
        self.goodsNum = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"goodsPayPrice"]) {
        self.goodsPayPrice = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"goodsPrice"]) {
        self.goodsPrice = [NSString stringWithFormat:@"%@", value];
    }else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}
@end
