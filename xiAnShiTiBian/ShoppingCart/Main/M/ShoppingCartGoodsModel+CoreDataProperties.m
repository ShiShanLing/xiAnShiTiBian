//
//  ShoppingCartGoodsModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShoppingCartGoodsModel+CoreDataProperties.h"

@implementation ShoppingCartGoodsModel (CoreDataProperties)

+ (NSFetchRequest<ShoppingCartGoodsModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ShoppingCartGoodsModel"];
}

@dynamic cartId;
@dynamic goodsId;
@dynamic goodsImages;
@dynamic goodsName;
@dynamic goodsNum;
@dynamic goodsPrice;
@dynamic isSelect;
@dynamic memberId;
@dynamic specId;
@dynamic specInfo;
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"goodsImages"]||[key isEqualToString:@"goodsImage"]) {
        self.goodsImages = value;
    }else if ([key isEqualToString:@"transGoodsNum"]) {
        
    }else {
        [super setValue:value forKey:key];
    }
    
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // [super setValue:value forUndefinedKey:key];
    
}

@end
