//
//  OrderDetailsModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/8.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderDetailsModel+CoreDataProperties.h"

@implementation OrderDetailsModel (CoreDataProperties)

+ (NSFetchRequest<OrderDetailsModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"OrderDetailsModel"];
}

@dynamic orderGoodsList;
@dynamic storeId;
@dynamic taxState;
@dynamic paySn;
@dynamic orderState;
@dynamic shippingFee;
@dynamic address;
@dynamic goodsAmount;
@dynamic orderAmount;
@dynamic carTaskId;
@dynamic orderSn;
@dynamic createTimeStr;
@dynamic orderId;
@dynamic buyingPatternsName;
@dynamic payId;
@dynamic storeName;
@dynamic orderTotalPrice;

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"taxState"]) {
        self.taxState = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"orderState"]) {
        self.orderState = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"shippingFee"]) {
        self.shippingFee = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"goodsAmount"]) {
        self.goodsAmount = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"orderAmount"]) {
        self.orderAmount = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"orderTotalPrice"]) {
        self.orderTotalPrice = [NSString stringWithFormat:@"%@", value];
    }else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {


}
@end
