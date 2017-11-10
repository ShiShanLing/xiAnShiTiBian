//
//  OrderShopNameTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *店铺名字点击事件 点击
 */
@protocol OrderShopNameTVCellDelegate <NSObject>
/**
 *点击的是第几个订单的 店铺名称
 */
- (void)ShopChoose:(int)index;

@end

/**
 *订单里面的商店名字
 */
@interface OrderShopNameTVCell : UITableViewCell

/**
 *  0 未付款 1 已付款未发货 2 已付款已发货 3 交易成功
 */
- (void)OrderState:(int)state indexPath:(NSIndexPath *)indexPath;

@property (nonatomic, strong)BuyersOrderListModel *model;

@property (nonatomic, assign)id<OrderShopNameTVCellDelegate>delegate;

@end

