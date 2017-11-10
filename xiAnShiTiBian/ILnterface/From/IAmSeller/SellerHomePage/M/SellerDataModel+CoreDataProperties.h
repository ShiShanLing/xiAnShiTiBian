//
//  SellerDataModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/9.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerDataModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SellerDataModel (CoreDataProperties)

+ (NSFetchRequest<SellerDataModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *areaInfo;
@property (nullable, nonatomic, copy) NSString *createTimeStr;
@property (nullable, nonatomic, copy) NSString *gradeId;
@property (nullable, nonatomic, copy) NSString *gradename;
@property (nullable, nonatomic, copy) NSString *memberId;
@property (nullable, nonatomic, copy) NSString *provinceId;
@property (nullable, nonatomic, copy) NSString *storeAddress;
@property (nullable, nonatomic, copy) NSString *storeclassname;
@property (nullable, nonatomic, copy) NSString *storeCode;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeLatitude;
@property (nullable, nonatomic, copy) NSString *storeLogo;
@property (nullable, nonatomic, copy) NSString *storeLongitude;
@property (nullable, nonatomic, copy) NSString *storeMainClass;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nullable, nonatomic, copy) NSString *storeQq;
@property (nullable, nonatomic, copy) NSString *storeState;
@property (nullable, nonatomic, copy) NSString *storeTel;
@property (nullable, nonatomic, copy) NSString *storeTheme;
@property (nullable, nonatomic, copy) NSString *storeZy;
@property (nullable, nonatomic, copy) NSString *shopIntroduced;
-(void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
