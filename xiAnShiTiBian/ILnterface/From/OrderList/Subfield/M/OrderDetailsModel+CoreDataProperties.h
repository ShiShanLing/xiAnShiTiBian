//
//  OrderDetailsModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/8.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderDetailsModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailsModel (CoreDataProperties)

+ (NSFetchRequest<OrderDetailsModel *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *orderGoodsList;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *taxState;
@property (nullable, nonatomic, copy) NSString *paySn;
@property (nullable, nonatomic, copy) NSString *orderState;
@property (nullable, nonatomic, copy) NSString *shippingFee;
@property (nullable, nonatomic, retain) NSObject *address;
@property (nullable, nonatomic, retain) NSObject *goodsAmount;
@property (nullable, nonatomic, copy) NSString *orderAmount;
@property (nullable, nonatomic, copy) NSString *carTaskId;
@property (nullable, nonatomic, copy) NSString *orderSn;
@property (nullable, nonatomic, copy) NSString *createTimeStr;
@property (nullable, nonatomic, copy) NSString *orderId;
@property (nullable, nonatomic, copy) NSString *buyingPatternsName;
@property (nullable, nonatomic, copy) NSString *payId;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nullable, nonatomic, copy) NSString *orderTotalPrice;
- (void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
