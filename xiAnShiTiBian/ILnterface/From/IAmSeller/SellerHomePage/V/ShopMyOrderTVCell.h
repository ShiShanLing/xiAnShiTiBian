//
//  ShopMyOrderTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopMyOrderTVCellDelegate <NSObject>
/**
 *你选择的订单状态 200 待付款 201待发货 202待收货
 */
- (void)SelectOrderStatus:(int)index;

@end

/**
 *商家的订单列表
 */
@interface ShopMyOrderTVCell : UITableViewCell

@property (nonatomic, assign)id<ShopMyOrderTVCellDelegate>delegate;

@end
