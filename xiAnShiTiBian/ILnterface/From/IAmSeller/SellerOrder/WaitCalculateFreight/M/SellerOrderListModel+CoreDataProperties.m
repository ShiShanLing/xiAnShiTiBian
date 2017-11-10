//
//  SellerOrderListModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerOrderListModel+CoreDataProperties.h"

@implementation SellerOrderListModel (CoreDataProperties)

+ (NSFetchRequest<SellerOrderListModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SellerOrderListModel"];
}

@dynamic address;
@dynamic addressId;
@dynamic beSelected;
@dynamic buyerId;
@dynamic buyerName;
@dynamic createTime;
@dynamic createTimeStr;
@dynamic orderGoodsList;
@dynamic orderId;
@dynamic orderSn;
@dynamic orderState;
@dynamic orderTotalPrice;
@dynamic payId;
@dynamic paymentCode;
@dynamic paymentState;
@dynamic paySn;
@dynamic storeId;
@dynamic storeName;
@dynamic taxState;
@dynamic orderAmount;
@dynamic shippingFee;

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"paymentState"]) {
        self.paymentState = [NSString stringWithFormat:@"%@", value];
        self.beSelected = NO;
    }else if([key isEqualToString:@"paymentCode"]){
        self.paymentCode = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"taxState"]){
        self.taxState = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"orderState"]){
        self.orderState = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"orderTotalPrice"]){
        self.orderTotalPrice = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"buyerId"]){
        
    }else if([key isEqualToString:@"createTime"]){
        self.createTime = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"shippingFee"]){
        self.shippingFee = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"orderAmount"]){
        self.orderAmount = [NSString stringWithFormat:@"%@", value];
    }else{
        [super setValue:value forKey:key];
    }
}



-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    
}
@end
