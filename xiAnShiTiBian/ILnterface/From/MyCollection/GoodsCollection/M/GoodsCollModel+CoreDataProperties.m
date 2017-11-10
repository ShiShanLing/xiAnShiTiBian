//
//  GoodsCollModel+CoreDataProperties.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "GoodsCollModel+CoreDataProperties.h"

@implementation GoodsCollModel (CoreDataProperties)

+ (NSFetchRequest<GoodsCollModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GoodsCollModel"];
}

@dynamic commentnum;
@dynamic cityName;
@dynamic createTimeStr;
@dynamic evaluate;
@dynamic goodsCollect;
@dynamic goodsId;
@dynamic goodsImage;
@dynamic goodsName;
@dynamic goodsStorePrice;
@dynamic goodsSubtitle;
@dynamic salenum;
@dynamic goodsTransfeeCharge;
@dynamic updateTimeStr;
@dynamic isEditor;
- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"isEditor"]) {
        self.isEditor = NO;
    }else if ([key isEqualToString:@"evaluate"]) {
        self.evaluate = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"goodsCollect"]){
        self.goodsCollect = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"goodsStorePrice"]){
        self.goodsStorePrice = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"salenum"]){
        self.salenum = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"goodsTransfeeCharge"]){
        self.goodsTransfeeCharge = [NSString stringWithFormat:@"%@", value];
    }else if ([key isEqualToString:@"commentnum"]){
        self.commentnum = [NSString stringWithFormat:@"%@", value];
    }else{
        [super setValue:value forKey:key];
    }
    

}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {


}
@end
