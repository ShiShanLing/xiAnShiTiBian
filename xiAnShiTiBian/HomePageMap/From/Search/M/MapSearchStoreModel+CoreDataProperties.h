//
//  MapSearchStoreModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapSearchStoreModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MapSearchStoreModel (CoreDataProperties)

+ (NSFetchRequest<MapSearchStoreModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *storeCredit;
@property (nullable, nonatomic, copy) NSString *storeQq;
@property (nullable, nonatomic, copy) NSString *storeLogo;
@property (nullable, nonatomic, copy) NSString *storeTel;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nullable, nonatomic, copy) NSString *gradename;
@property (nullable, nonatomic, copy) NSString *storeLongitude;
@property (nullable, nonatomic, copy) NSString *storeLatitude;
@property (nullable, nonatomic, copy) NSString *storeMainClass;
@property (nullable, nonatomic, copy) NSString *areaInfo;
@property (nullable, nonatomic, copy) NSString *storeAddress;

-(void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
