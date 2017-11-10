//
//  BuyersOrderListModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "BuyersOrderListModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BuyersOrderListModel (CoreDataProperties)

+ (NSFetchRequest<BuyersOrderListModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *addTime;
@property (nullable, nonatomic, copy) NSString *buyerName;
@property (nullable, nonatomic, retain) NSObject *orderGoodsList;
@property (nullable, nonatomic, copy) NSString *orderId;
@property (nullable, nonatomic, copy) NSString *orderSn;
@property (nullable, nonatomic, copy) NSString *orderState;
@property (nullable, nonatomic, copy) NSString *payId;
@property (nullable, nonatomic, copy) NSString *paymentDirect;
@property (nullable, nonatomic, copy) NSString *paymentName;
@property (nullable, nonatomic, copy) NSString *paySn;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nullable, nonatomic, copy) NSString *orderAmount;
@property (nullable, nonatomic, copy) NSString *shippingFee;
-(void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
