//
//  StoreRankingListModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/24.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "StoreRankingListModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StoreRankingListModel (CoreDataProperties)

//+ (NSFetchRequest<StoreRankingListModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *storeAddress;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeLatitude;
@property (nullable, nonatomic, copy) NSString *storeLogo;
@property (nullable, nonatomic, copy) NSString *storeLongitude;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nonatomic) int16_t storeSales;
@property (nullable, nonatomic, copy) NSString *storeTel;
@property (nullable, nonatomic, copy) NSString *storeBanner;
@property (nullable, nonatomic, copy) NSString *gradename;
@property (nullable, nonatomic, copy) NSString *bankName;
@property (nullable, nonatomic, copy) NSString *storeQq;
@property (nullable, nonatomic, copy) NSString *areaInfo;
@property (nullable, nonatomic, copy) NSString *createTimeStr;
-(void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
