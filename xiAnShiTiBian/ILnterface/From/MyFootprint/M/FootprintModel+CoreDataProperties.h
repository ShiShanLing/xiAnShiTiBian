//
//  FootprintModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/8/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "FootprintModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FootprintModel (CoreDataProperties)

+ (NSFetchRequest<FootprintModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *create_time_str;
@property (nullable, nonatomic, retain) NSObject *goodsList;
-(void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
