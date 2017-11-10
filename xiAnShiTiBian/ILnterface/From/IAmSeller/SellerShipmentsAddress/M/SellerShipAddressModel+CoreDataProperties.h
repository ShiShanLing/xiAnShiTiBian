//
//  SellerShipAddressModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/11.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerShipAddressModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SellerShipAddressModel (CoreDataProperties)

+ (NSFetchRequest<SellerShipAddressModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *provinceId;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *company;
@property (nullable, nonatomic, copy) NSString *telPhone;
@property (nullable, nonatomic, copy) NSString *addressId;
@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSString *cityId;
@property (nullable, nonatomic, copy) NSString *mobPhone;
@property (nullable, nonatomic, copy) NSString *sellerName;
@property (nullable, nonatomic, copy) NSString *zipCode;
@property (nullable, nonatomic, copy) NSString *isDefault;
@property (nullable, nonatomic, copy) NSString *areaInfo;
@property (nullable, nonatomic, copy) NSString *areaId;
-(void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
