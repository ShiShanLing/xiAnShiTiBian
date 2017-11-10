//
//  ShoppingCartStoreModel+CoreDataProperties.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/22.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShoppingCartStoreModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartStoreModel (CoreDataProperties)

+ (NSFetchRequest<ShoppingCartStoreModel *> *)fetchRequest;

@property (nonatomic) int16_t goodsNum;
@property (nonatomic) BOOL isEditor;
@property (nonatomic) BOOL isSelect;
@property (nullable, nonatomic, retain) NSObject *list;
@property (nullable, nonatomic, copy) NSString *storeId;
@property (nullable, nonatomic, copy) NSString *storeName;
-(void)setValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
