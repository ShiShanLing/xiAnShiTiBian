//
//  IntegralListModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/19.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "IntegralListModel+CoreDataProperties.h"

@implementation IntegralListModel (CoreDataProperties)

+ (NSFetchRequest<IntegralListModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"IntegralListModel"];
}

@dynamic operationTimt;
@dynamic operationId;
@dynamic operationPoint;
@dynamic operationType;
@dynamic memberId;
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"operationType"]) {
        self.operationType = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"operationId"]) {
        self.operationId = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"operationPoint"]) {
        self.operationPoint = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"operationTimt"]) {
        
        NSString *str=[NSString stringWithFormat:@"%@", value];
        NSTimeInterval time=[str doubleValue]/1000;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        
        self.operationTimt = detaildate;
       
    }else {
    
        [super setValue:value forKey:key];
    }

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end
