//
//  DriverCarOrderModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverCarOrderModel+CoreDataProperties.h"

@implementation DriverCarOrderModel (CoreDataProperties)

+ (NSFetchRequest<DriverCarOrderModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DriverCarOrderModel"];
}

@dynamic address;
@dynamic beSelected;
@dynamic buyerLatitude;
@dynamic buyerLongitude;
@dynamic buyerMobile;
@dynamic buyerName;
@dynamic carOwnerId;
@dynamic createTime;
@dynamic daddress;
@dynamic dricerOrderId;
@dynamic goodsName;
@dynamic leaveMessage;
@dynamic memberMobile;
@dynamic orderId;
@dynamic storeId;
@dynamic storeLatitude;
@dynamic storeLongitude;
@dynamic storeName;
@dynamic storeTel;
@dynamic state;
@dynamic transportCharge;
-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"state"]) {
        self.state = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"id"]) {
        self.beSelected = NO;
        self.dricerOrderId = value;
    }else if([key isEqualToString:@"createTime"]||[key isEqualToString:@"create_time"]){
        NSString *str=[NSString stringWithFormat:@"%@", value];
        NSTimeInterval time=[str doubleValue]/1000;
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        self.createTime = detaildate;
    }else if([key isEqualToString:@"storeLatitude"]||[key isEqualToString:@"store_latitude"]){
        self.storeLatitude = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"storeLongitude"]||[key isEqualToString:@"store_longitude"]){
        self.storeLongitude = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"transportCharge"]||[key isEqualToString:@"transport_charge"]){
        self.transportCharge = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"buyerLatitude"]||[key isEqualToString:@"buyer_latitude"]){
        self.buyerLatitude = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"buyerLongitude"]||[key isEqualToString:@"buyer_longitude"]){
        self.buyerLongitude = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"description"]){
        self.leaveMessage = value;
    }else if([key isEqualToString:@"store_id"]||[key isEqualToString:@"storeId"]){
        self.storeId = value;
    }else if([key isEqualToString:@"store_tel"]||[key isEqualToString:@"storeTel"]){
        self.storeTel = value;
    }else if([key isEqualToString:@"store_name"]||[key isEqualToString:@"storeName"]){
        self.storeName = value;
    }else if([key isEqualToString:@"order_id"]||[key isEqualToString:@"orderId"]){
        self.orderId = value;
    }else if([key isEqualToString:@"member_mobile"]||[key isEqualToString:@"memberMobile"]){
        self.memberMobile = value;
    }else if([key isEqualToString:@"goods_name"]||[key isEqualToString:@"goodsName"]){
        self.goodsName = value;
    }else if([key isEqualToString:@"dricer_order_id"]||[key isEqualToString:@"dricerOrderId"]){
        self.dricerOrderId = value;
    }else if([key isEqualToString:@"car_owner_id"]||[key isEqualToString:@"carOwnerId"]){
        self.carOwnerId = value;
    }else if([key isEqualToString:@"buyer_name"]||[key isEqualToString:@"buyerName"]){
        self.buyerName = value;
    }else if([key isEqualToString:@"buyer_mobile"]||[key isEqualToString:@"buyerMobile"]){
        self.buyerMobile = value;
    }else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
    
}
@end
