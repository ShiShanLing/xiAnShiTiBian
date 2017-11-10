//
//  DriverCarOrderDetailsModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverCarOrderDetailsModel+CoreDataProperties.h"

@implementation DriverCarOrderDetailsModel (CoreDataProperties)

+ (NSFetchRequest<DriverCarOrderDetailsModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DriverCarOrderDetailsModel"];
}

@dynamic buyer_name;
@dynamic transport_charge;
@dynamic leaveMessage;
@dynamic create_time;
@dynamic store_latitude;
@dynamic store_tel;
@dynamic address;
@dynamic goods_name;
@dynamic store_id;
@dynamic buyer_longitude;
@dynamic buyer_mobile;
@dynamic store_longitude;
@dynamic buyer_latitude;
@dynamic store_name;
@dynamic member_mobile;
@dynamic carTaskId;
@dynamic state;
@dynamic order_id;
@dynamic daddress;
-(void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"state"]) {
        self.state = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"id"]) {
    
        self.carTaskId = value;
    }else if ([key isEqualToString:@"store_latitude"]){
        self.store_latitude = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"create_time"]){
        self.create_time = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"transport_charge"]){
        self.transport_charge = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"buyer_longitude"]){
        self.buyer_longitude = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"store_longitude"]){
        self.store_longitude = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"buyer_latitude"]){
        self.buyer_latitude = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"description"]){
        self.leaveMessage = [NSString stringWithFormat:@"%@", value];
    }else{
        [super setValue:value forKey:key];
    }
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}
@end
