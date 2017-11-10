//
//  FactoryDataModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "FactoryDataModel+CoreDataProperties.h"

@implementation FactoryDataModel (CoreDataProperties)

+ (NSFetchRequest<FactoryDataModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FactoryDataModel"];
}

@dynamic factoryAddress;
@dynamic factoryId;
@dynamic factoryLatitude;
@dynamic factoryName;
@dynamic factoryTel;
@dynamic listGoods;
@dynamic listStore;
@dynamic factoryDescription;
@dynamic factoryType;
@dynamic factoryLongitude;

- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}
@end
