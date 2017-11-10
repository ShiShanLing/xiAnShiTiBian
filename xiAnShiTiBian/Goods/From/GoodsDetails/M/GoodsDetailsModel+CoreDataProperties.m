//
//  GoodsDetailsModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/4/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "GoodsDetailsModel+CoreDataProperties.h"

@implementation GoodsDetailsModel (CoreDataProperties)

+ (NSFetchRequest<GoodsDetailsModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GoodsDetailsModel"];
}

@dynamic giftPoints;
@dynamic goodCostPrice;
@dynamic goodsBody;
@dynamic goodsDescription;
@dynamic goodsId;
@dynamic goodsImage;
@dynamic goodsImageMore;
@dynamic goodsMarketPrice;
@dynamic goodsName;
@dynamic goodsSpec;
@dynamic goodsStorePrice;
@dynamic goodsSubtitle;
@dynamic salenum;
@dynamic specName;
@dynamic storeId;
@dynamic storeName;

-(void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"giftPoints"]) {
        
        self.giftPoints = [NSString stringWithFormat:@"%@", value].integerValue;
        
    }else if ([key isEqualToString:@"goodsMarketPrice"]) {
        
        self.goodsMarketPrice = [NSString stringWithFormat:@"%@", value].floatValue;
        
    }else if ([key isEqualToString:@"goodCostPrice"]) {
        
        self.goodCostPrice = [NSString stringWithFormat:@"%@", value].floatValue;
        
    }else  if ([key isEqualToString:@"goodsBody"]) {
        
        self.goodsBody = [NSString stringWithFormat:@"%@", value];
        
    }else  if ([key isEqualToString:@"goodsDescription"]) {
        
        self.goodsDescription = [NSString stringWithFormat:@"%@", value];
        
    }else  if ([key isEqualToString:@"goodsId"]) {
        
        self.goodsId = [NSString stringWithFormat:@"%@", value];
        
    }else  if ([key isEqualToString:@"goodsImage"]) {
        
        self.goodsImage = [NSString stringWithFormat:@"%@", value];
        
    }else  if ([key isEqualToString:@"goodsName"]) {
        
        self.goodsName = [NSString stringWithFormat:@"%@", value];
        
    }else if ([key isEqualToString:@"goodsStorePrice"]) {
        
        self.goodsStorePrice = [NSString stringWithFormat:@"%@", value].floatValue;
        
    }else if ([key isEqualToString:@"goodsSubtitle"]) {
        
        self.goodsSubtitle = [NSString stringWithFormat:@"%@", value];
        
    }else if ([key isEqualToString:@"salenum"]) {
        
        self.salenum = [NSString stringWithFormat:@"%@", value].integerValue;
        
    }else if ([key isEqualToString:@"storeId"]) {
        
        self.storeId = [NSString stringWithFormat:@"%@", value];
        
    }else  {
        [super setValue:value forKey:key];
    }
    
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {



}

@end
