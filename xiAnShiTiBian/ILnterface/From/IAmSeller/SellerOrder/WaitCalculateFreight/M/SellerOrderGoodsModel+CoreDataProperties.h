//
//  SellerOrderGoodsModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerOrderGoodsModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SellerOrderGoodsModel (CoreDataProperties)

+ (NSFetchRequest<SellerOrderGoodsModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *buyerId;
@property (nullable, nonatomic, copy) NSString *gcId;
@property (nullable, nonatomic, copy) NSString *goodsId;
@property (nullable, nonatomic, copy) NSString *goodsImage;
@property (nullable, nonatomic, copy) NSString *goodsName;
@property (nullable, nonatomic, copy) NSString *goodsNum;
@property (nullable, nonatomic, copy) NSString *goodsPayPrice;
@property (nullable, nonatomic, copy) NSString *goodsPrice;
@property (nullable, nonatomic, copy) NSString *orderId;
@property (nullable, nonatomic, copy) NSString *recId;
@property (nullable, nonatomic, copy) NSString *specId;
@property (nullable, nonatomic, copy) NSString *specInfo;
@property (nullable, nonatomic, copy) NSString *storeId;
- (void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
