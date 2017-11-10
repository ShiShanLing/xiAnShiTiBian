//
//  DriverCarOrderDetailsModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverCarOrderDetailsModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DriverCarOrderDetailsModel (CoreDataProperties)

+ (NSFetchRequest<DriverCarOrderDetailsModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *buyer_name;
@property (nullable, nonatomic, copy) NSString *transport_charge;
@property (nullable, nonatomic, copy) NSString *leaveMessage;
@property (nullable, nonatomic, copy) NSString *create_time;
@property (nullable, nonatomic, copy) NSString *store_latitude;
@property (nullable, nonatomic, copy) NSString *store_tel;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *goods_name;
@property (nullable, nonatomic, copy) NSString *store_id;
@property (nullable, nonatomic, copy) NSString *buyer_longitude;
@property (nullable, nonatomic, copy) NSString *buyer_mobile;
@property (nullable, nonatomic, copy) NSString *store_longitude;
@property (nullable, nonatomic, copy) NSString *buyer_latitude;
@property (nullable, nonatomic, copy) NSString *store_name;
@property (nullable, nonatomic, copy) NSString *member_mobile;
@property (nullable, nonatomic, copy) NSString *carTaskId;
@property (nullable, nonatomic, copy) NSString *state;
@property (nullable, nonatomic, copy) NSString *order_id;
@property (nullable, nonatomic, copy) NSString *daddress;

@end

NS_ASSUME_NONNULL_END
