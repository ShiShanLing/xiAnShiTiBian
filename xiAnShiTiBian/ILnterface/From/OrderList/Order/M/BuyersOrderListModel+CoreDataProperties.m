//
//  BuyersOrderListModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "BuyersOrderListModel+CoreDataProperties.h"

@implementation BuyersOrderListModel (CoreDataProperties)

+ (NSFetchRequest<BuyersOrderListModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BuyersOrderListModel"];
}

@dynamic addTime;
@dynamic buyerName;
@dynamic orderGoodsList;
@dynamic orderId;
@dynamic orderSn;
@dynamic orderState;
@dynamic payId;
@dynamic paymentDirect;
@dynamic paymentName;
@dynamic paySn;
@dynamic storeId;
@dynamic storeName;
@dynamic orderAmount;
@dynamic shippingFee;
-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"addTime"]) {
        NSString *str=[NSString stringWithFormat:@"%@", value];
        NSTimeInterval time=[str doubleValue]/1000;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        NSLog(@"date:%@",currentDateStr);
        self.addTime = detaildate;
    }else if([key isEqualToString:@"orderState"]){
        self.orderState = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"orderAmount"]){
        self.orderAmount = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"shippingFee"]){
        self.shippingFee = [NSString stringWithFormat:@"%@", value];
    }else{
        [super setValue:value forKey:key];
    }
    
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

@end
