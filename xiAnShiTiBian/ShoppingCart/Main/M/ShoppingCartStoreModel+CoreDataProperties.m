//
//  ShoppingCartStoreModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShoppingCartStoreModel+CoreDataProperties.h"

@implementation ShoppingCartStoreModel (CoreDataProperties)

+ (NSFetchRequest<ShoppingCartStoreModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ShoppingCartStoreModel"];
}

@dynamic goodsNum;
@dynamic isEditor;
@dynamic isSelect;
@dynamic list;
@dynamic storeId;
@dynamic storeName;
-(void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {


}
@end
