//
//  ShippingAddressModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShippingAddressModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ShippingAddressModel (CoreDataProperties)

+ (NSFetchRequest<ShippingAddressModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *addressId;
@property (nullable, nonatomic, copy) NSString *areaInfo;
@property (nullable, nonatomic, copy) NSString *isDefault;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *memberId;
@property (nullable, nonatomic, copy) NSString *mobPhone;
@property (nullable, nonatomic, copy) NSString *trueName;
-(void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
