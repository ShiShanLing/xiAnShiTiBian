//
//  ShippingAddressModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShippingAddressModel+CoreDataProperties.h"

@implementation ShippingAddressModel (CoreDataProperties)

+ (NSFetchRequest<ShippingAddressModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ShippingAddressModel"];
}

@dynamic address;
@dynamic addressId;
@dynamic areaInfo;
@dynamic isDefault;
@dynamic latitude;
@dynamic longitude;
@dynamic memberId;
@dynamic mobPhone;
@dynamic trueName;
-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"isDefault"]) {
        self.isDefault = value;
    }else {
        [super setValue:value forKey:key];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key { }


@end
