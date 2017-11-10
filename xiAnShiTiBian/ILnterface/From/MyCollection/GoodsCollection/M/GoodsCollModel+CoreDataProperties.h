//
//  GoodsCollModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "GoodsCollModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN
/**
 *商品收藏model
 */
@interface GoodsCollModel (CoreDataProperties)

+ (NSFetchRequest<GoodsCollModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *commentnum;
@property (nullable, nonatomic, copy) NSString *cityName;
@property (nullable, nonatomic, copy) NSString *createTimeStr;
@property (nullable, nonatomic, copy) NSString *evaluate;
@property (nullable, nonatomic, copy) NSString *goodsCollect;
@property (nullable, nonatomic, copy) NSString *goodsId;
@property (nullable, nonatomic, copy) NSString *goodsImage;
@property (nullable, nonatomic, copy) NSString *goodsName;
@property (nullable, nonatomic, copy) NSString *goodsStorePrice;
@property (nullable, nonatomic, copy) NSString *goodsSubtitle;
@property (nullable, nonatomic, copy) NSString *salenum;
@property (nullable, nonatomic, copy) NSString *goodsTransfeeCharge;
@property (nullable, nonatomic, copy) NSString *updateTimeStr;
/**
 *是否被编辑
 */
@property (nonatomic) BOOL isEditor;
- (void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
