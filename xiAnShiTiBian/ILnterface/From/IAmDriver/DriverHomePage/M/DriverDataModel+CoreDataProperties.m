//
//  DriverDataModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverDataModel+CoreDataProperties.h"

@implementation DriverDataModel (CoreDataProperties)

+ (NSFetchRequest<DriverDataModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DriverDataModel"];
}

@dynamic carLicenseNumber;
@dynamic carMotorVehicles;
@dynamic carOwnerId;
@dynamic carOwnerName;
@dynamic carType;
@dynamic carVehicleBrand;
@dynamic idCardNo;
@dynamic memberId;
@dynamic registrationDate;
@dynamic state;
@dynamic memberMobile;
-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"state"]) {
        self.state = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"memberMobile"]) {
        self.memberMobile = [NSString stringWithFormat:@"%@", value];
    }else{
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}
@end
