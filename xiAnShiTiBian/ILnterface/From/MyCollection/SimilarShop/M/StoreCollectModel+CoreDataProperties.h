//
//  StoreCollectModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "StoreCollectModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface StoreCollectModel (CoreDataProperties)

+ (NSFetchRequest<StoreCollectModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeName;
@property (nullable, nonatomic, copy) NSString *storeLogo;
@property (nullable, nonatomic, copy) NSString *storeGoodsCount;
@property (nullable, nonatomic, copy) NSDate *favTime;
@property (nullable, nonatomic, copy) NSString *storeCollect;
@property (nonatomic) BOOL isEditor;
- (void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
