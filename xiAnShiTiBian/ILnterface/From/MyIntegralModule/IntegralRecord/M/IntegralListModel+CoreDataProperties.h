//
//  IntegralListModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/19.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "IntegralListModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface IntegralListModel (CoreDataProperties)

+ (NSFetchRequest<IntegralListModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *operationTimt;
@property (nullable, nonatomic, copy) NSString *operationId;
@property (nullable, nonatomic, copy) NSString *operationPoint;
@property (nullable, nonatomic, copy) NSString *operationType;
@property (nullable, nonatomic, copy) NSString *memberId;


- (void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
