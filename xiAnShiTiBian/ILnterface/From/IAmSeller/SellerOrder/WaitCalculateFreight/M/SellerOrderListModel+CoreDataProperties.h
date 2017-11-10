//
//  SellerOrderListModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerOrderListModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SellerOrderListModel (CoreDataProperties)

+ (NSFetchRequest<SellerOrderListModel *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *address;
@property (nullable, nonatomic, copy) NSString *addressId;
@property (nonatomic) BOOL beSelected;
@property (nonatomic) BOOL buyerId;
@property (nullable, nonatomic, copy) NSString *buyerName;
@property (nullable, nonatomic, copy) NSString *createTime;
@property (nullable, nonatomic, copy) NSString *createTimeStr;
@property (nullable, nonatomic, retain) NSObject *orderGoodsList;
@property (nullable, nonatomic, copy) NSString *orderId;
@property (nullable, nonatomic, copy) NSString *orderSn;
@property (nullable, nonatomic, copy) NSString *orderState;
@property (nullable, nonatomic, copy) NSString *orderTotalPrice;
@property (nullable, nonatomic, copy) NSString *payId;
@property (nullable, nonatomic, copy) NSString *paymentCode;
@property (nullable, nonatomic, copy) NSString *paymentState;
@property (nullable, nonatomic, copy) NSString *paySn;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nullable, nonatomic, copy) NSString *taxState;
@property (nullable, nonatomic, copy) NSString *orderAmount;
@property (nullable, nonatomic, copy) NSString *shippingFee;

- (void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
