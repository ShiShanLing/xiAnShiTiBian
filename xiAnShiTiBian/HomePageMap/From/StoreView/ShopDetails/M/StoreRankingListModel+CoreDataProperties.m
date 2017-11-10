//
//  StoreRankingListModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "StoreRankingListModel+CoreDataProperties.h"

@implementation StoreRankingListModel (CoreDataProperties)

+ (NSFetchRequest<StoreRankingListModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"StoreRankingListModel"];
}

@dynamic storeAddress;
@dynamic storeId;
@dynamic storeLatitude;
@dynamic storeLogo;
@dynamic storeLongitude;
@dynamic storeName;
@dynamic storeSales;
@dynamic storeTel;
@dynamic storeBanner;
@dynamic gradename;
@dynamic bankName;
@dynamic storeQq;
@dynamic areaInfo;
@dynamic createTimeStr;

-(void)setValue:(id)value forKey:(NSString *)key {
   // NSLog(@"value%@key%@",value, key);
    if ([key isEqualToString:@"storeLongitude"]) {
        self.storeLongitude = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"storeLatitude"]) {
        self.storeLatitude = [NSString stringWithFormat:@"%@", value];
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {



}

@end
