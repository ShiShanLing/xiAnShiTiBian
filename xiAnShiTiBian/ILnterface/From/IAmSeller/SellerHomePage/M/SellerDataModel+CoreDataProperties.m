//
//  SellerDataModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/9.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerDataModel+CoreDataProperties.h"

@implementation SellerDataModel (CoreDataProperties)

+ (NSFetchRequest<SellerDataModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SellerDataModel"];
}

@dynamic areaInfo;
@dynamic createTimeStr;
@dynamic gradeId;
@dynamic gradename;
@dynamic memberId;
@dynamic provinceId;
@dynamic storeAddress;
@dynamic storeclassname;
@dynamic storeCode;
@dynamic storeId;
@dynamic storeLatitude;
@dynamic storeLogo;
@dynamic storeLongitude;
@dynamic storeMainClass;
@dynamic storeName;
@dynamic storeQq;
@dynamic storeState;
@dynamic storeTel;
@dynamic storeTheme;
@dynamic storeZy;
@dynamic shopIntroduced;

-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"storeState"]) {
        self.storeState = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"description"]) {
        self.shopIntroduced = [NSString stringWithFormat:@"%@", value];
    }else {
        [super setValue:value forKey:key];
    }
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

@end
