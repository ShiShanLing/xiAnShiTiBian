//
//  DriverDataModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverDataModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DriverDataModel (CoreDataProperties)

+ (NSFetchRequest<DriverDataModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *carLicenseNumber;
@property (nullable, nonatomic, copy) NSString *carMotorVehicles;
@property (nullable, nonatomic, copy) NSString *carOwnerId;
@property (nullable, nonatomic, copy) NSString *carOwnerName;
@property (nullable, nonatomic, copy) NSString *carType;
@property (nullable, nonatomic, copy) NSString *carVehicleBrand;
@property (nullable, nonatomic, copy) NSString *idCardNo;
@property (nullable, nonatomic, copy) NSString *memberId;
@property (nullable, nonatomic, copy) NSString *registrationDate;
@property (nullable, nonatomic, copy) NSString *state;
@property (nullable, nonatomic, copy) NSString *memberMobile;

@end

NS_ASSUME_NONNULL_END
