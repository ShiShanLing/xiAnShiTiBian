//
//  BuyersOrderGoodsModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/30.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "BuyersOrderGoodsModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BuyersOrderGoodsModel (CoreDataProperties)

+ (NSFetchRequest<BuyersOrderGoodsModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *goodsId;
@property (nullable, nonatomic, copy) NSString *goodsImage;
@property (nullable, nonatomic, copy) NSString *goodsName;
@property (nonatomic) int16_t goodsNum;
@property (nonatomic) float goodsPrice;
@property (nullable, nonatomic, retain) NSObject *specInfo;
- (void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
