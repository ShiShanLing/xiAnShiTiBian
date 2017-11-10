//
//  SellerShipAddressModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/11.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerShipAddressModel+CoreDataProperties.h"

@implementation SellerShipAddressModel (CoreDataProperties)

+ (NSFetchRequest<SellerShipAddressModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SellerShipAddressModel"];
}

@dynamic provinceId;
@dynamic storeId;
@dynamic address;
@dynamic company;
@dynamic telPhone;
@dynamic addressId;
@dynamic content;
@dynamic cityId;
@dynamic mobPhone;
@dynamic sellerName;
@dynamic zipCode;
@dynamic isDefault;
@dynamic areaInfo;
@dynamic areaId;
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"zipCode"]) {
        self.zipCode = [NSString stringWithFormat:@"%@", value];
    }else {
    [super setValue:value forKey:key];
    }

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {


}
@end
