//
//  StoreCollectModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "StoreCollectModel+CoreDataProperties.h"

@implementation StoreCollectModel (CoreDataProperties)

+ (NSFetchRequest<StoreCollectModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"StoreCollectModel"];
}

@dynamic storeId;
@dynamic storeName;
@dynamic storeLogo;
@dynamic storeGoodsCount;
@dynamic favTime;
@dynamic storeCollect;
@dynamic isEditor;
-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"isEditor"]) {
        self.isEditor = NO;
    }else if ([key isEqualToString:@"storeCollect"]) {
        self.storeCollect = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"favTime"]){
        NSString *str=[NSString stringWithFormat:@"%@", value];
        NSTimeInterval time=[str doubleValue]/1000;//因为时差问题要加8小时 == 28800 sec
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
        self.favTime = detaildate;
    }else if ([key isEqualToString:@"storeGoodsCount"]) {
        self.storeGoodsCount = [NSString stringWithFormat:@"%@", value];
    }else {
        NSLog(@"value %@ key %@", value, key);
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {


}
@end
