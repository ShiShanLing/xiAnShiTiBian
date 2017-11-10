//
//  FactoryDataModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "FactoryDataModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FactoryDataModel (CoreDataProperties)

+ (NSFetchRequest<FactoryDataModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *factoryAddress;
@property (nullable, nonatomic, copy) NSString *factoryId;
@property (nullable, nonatomic, copy) NSString *factoryLatitude;
/**
 *
 */
@property (nullable, nonatomic, copy) NSString *factoryLongitude;
@property (nullable, nonatomic, copy) NSString *factoryName;
@property (nullable, nonatomic, copy) NSString *factoryTel;
@property (nullable, nonatomic, retain) NSObject *listGoods;
@property (nullable, nonatomic, retain) NSObject *listStore;
@property (nullable, nonatomic, copy) NSString *factoryDescription;
@property (nullable, nonatomic, copy) NSString *factoryType;
- (void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
