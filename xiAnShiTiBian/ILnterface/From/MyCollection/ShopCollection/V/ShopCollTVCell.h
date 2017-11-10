//
//  ShopCollTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/9.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreCollectModel+CoreDataProperties.h"
@protocol ShopCollTVCellDelegate <NSObject>
/**
 *收藏店铺编辑事件
 */
-(void)collShopEditor:(UIButton *)sender;
/**
 *找相似的店铺
 */
- (void)similarShop:(UIButton *)sender;
@end

@interface ShopCollTVCell : UITableViewCell

@property (nonatomic, assign)id<ShopCollTVCellDelegate>delegate;

- (void)EditButtonTagAssignment:(NSIndexPath *)indexPaht;

@property (nonatomic, strong)StoreCollectModel *model;

@end
