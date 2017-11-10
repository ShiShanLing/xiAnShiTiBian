//
//  ShoppingCartGoodsModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShoppingCartGoodsModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartGoodsModel (CoreDataProperties)

+ (NSFetchRequest<ShoppingCartGoodsModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cartId;
@property (nullable, nonatomic, copy) NSString *goodsId;
@property (nullable, nonatomic, copy) NSString *goodsImages;
@property (nullable, nonatomic, copy) NSString *goodsName;
@property (nonatomic) int16_t goodsNum;
@property (nonatomic) float goodsPrice;
@property (nonatomic) BOOL isSelect;
@property (nullable, nonatomic, copy) NSString *memberId;
@property (nullable, nonatomic, copy) NSString *specId;
@property (nullable, nonatomic, retain) NSObject *specInfo;

- (void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
