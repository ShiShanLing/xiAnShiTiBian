//
//  RecentSearchCity+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/10/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//
//

#import "RecentSearchCity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RecentSearchCity (CoreDataProperties)

+ (NSFetchRequest<RecentSearchCity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, copy) NSString *provinceName;

- (void)setValue:(id)value forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
