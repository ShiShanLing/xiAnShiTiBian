//
//  DriverCarOrderModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverCarOrderModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DriverCarOrderModel (CoreDataProperties)

+ (NSFetchRequest<DriverCarOrderModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nonatomic) BOOL beSelected;
@property (nullable, nonatomic, copy) NSString *buyerLatitude;
@property (nullable, nonatomic, copy) NSString *buyerLongitude;
@property (nullable, nonatomic, copy) NSString *buyerMobile;
@property (nullable, nonatomic, copy) NSString *buyerName;
@property (nullable, nonatomic, copy) NSString *carOwnerId;
@property (nullable, nonatomic, copy) NSDate *createTime;
@property (nullable, nonatomic, copy) NSString *daddress;
@property (nullable, nonatomic, copy) NSString *dricerOrderId;
@property (nullable, nonatomic, copy) NSString *goodsName;
@property (nullable, nonatomic, copy) NSString *leaveMessage;
@property (nullable, nonatomic, copy) NSString *memberMobile;
@property (nullable, nonatomic, copy) NSString *orderId;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeLatitude;
@property (nullable, nonatomic, copy) NSString *storeLongitude;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nullable, nonatomic, copy) NSString *storeTel;
@property (nullable, nonatomic, copy) NSString *transportCharge;
@property (nullable, nonatomic, copy) NSString *state;
-(void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
