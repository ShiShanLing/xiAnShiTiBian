//
//  MapSearchStoreModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapSearchStoreModel+CoreDataProperties.h"

@implementation MapSearchStoreModel (CoreDataProperties)

+ (NSFetchRequest<MapSearchStoreModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MapSearchStoreModel"];
}

@dynamic storeCredit;
@dynamic storeQq;
@dynamic storeLogo;
@dynamic storeTel;
@dynamic storeId;
@dynamic storeName;
@dynamic gradename;
@dynamic storeLongitude;
@dynamic storeLatitude;
@dynamic storeMainClass;
@dynamic storeAddress;
@dynamic areaInfo;
-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"storeCredit"]) {
        self.storeCredit = [NSString stringWithFormat:@"%@", value];
    }else if([key isEqualToString:@"gradename"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.gradename = str;
    }else if([key isEqualToString:@"storeCredit"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeCredit = str;
    }else if([key isEqualToString:@"storeQq"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeQq = str;
    }else if([key isEqualToString:@"storeLogo"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeLogo = str;
    }else if([key isEqualToString:@"storeTel"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeTel = str;
    }else if([key isEqualToString:@"storeId"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeId = str;
    }else if([key isEqualToString:@"storeName"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeName = str;
    }else if([key isEqualToString:@"storeLongitude"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeLongitude = str;
    }else if([key isEqualToString:@"storeLatitude"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeLatitude = str;
    }else if([key isEqualToString:@"storeMainClass"]){
        NSString *str = [NSString stringWithFormat:@"%@", value];
        self.storeMainClass = str;
    }else{
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    

}
@end
