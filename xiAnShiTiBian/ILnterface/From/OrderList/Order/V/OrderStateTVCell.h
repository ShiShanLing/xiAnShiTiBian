//
//  OrderStateTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/11.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderStateTVCellDelegate <NSObject>
/**
 *显示的最后一个btn 通用的根据自定的btn里面的值 来判断点击的是第几个 点击的cell订单是什么类型的订单  0是待定运费 1是待付款 2是待发货 3是待收货 4是待评价
 */
- (void)OrderCommonBtnOne:(OrderBtn *)sender;
/**
 *显示的最后一个btn 通用的根据自定的btn里面的值 来判断点击的是第几个 点击的cell订单是什么类型的订单
 */
- (void)OrderCommonBtnTwo:(OrderBtn *)sender;


@end
/**
 *订单属性cell
 */
@interface OrderStateTVCell : UITableViewCell

@property (nonatomic, assign)id<OrderStateTVCellDelegate>delegate;

@property (nonatomic, strong)BuyersOrderListModel *model;

- (void)OrderStateBtn:(BuyersOrderListModel *)model indexPath:(NSIndexPath *)indexPath;

@end
