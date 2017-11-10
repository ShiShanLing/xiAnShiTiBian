//
//  GoodsDetailsModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "GoodsDetailsModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GoodsDetailsModel (CoreDataProperties)

+ (NSFetchRequest<GoodsDetailsModel *> *)fetchRequest;

@property (nonatomic) int16_t giftPoints;
@property (nonatomic) float goodCostPrice;
@property (nullable, nonatomic, copy) NSString *goodsBody;
@property (nullable, nonatomic, copy) NSString *goodsDescription;
@property (nullable, nonatomic, copy) NSString *goodsId;
@property (nullable, nonatomic, copy) NSString *goodsImage;
@property (nullable, nonatomic, retain) NSObject *goodsImageMore;
@property (nonatomic) float goodsMarketPrice;
@property (nullable, nonatomic, copy) NSString *goodsName;
@property (nullable, nonatomic, retain) NSObject *goodsSpec;
@property (nonatomic) float goodsStorePrice;
@property (nullable, nonatomic, copy) NSString *goodsSubtitle;
@property (nonatomic) int16_t salenum;
@property (nullable, nonatomic, retain) NSObject *specName;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeName;

-(void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
