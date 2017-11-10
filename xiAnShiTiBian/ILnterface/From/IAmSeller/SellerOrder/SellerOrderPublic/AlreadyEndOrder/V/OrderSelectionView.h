//
//  OrderSelectionView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol OrderSelectionViewDelegate <NSObject>
/**
 *选择订单的折扣
 */
- (void)SelectDiscount;
/**
 *按照订单时间选择订单
 */
- (void)SelectOrderTime;
@end

/**
 *商家已经完成的订单类型选择view  
 */
@interface OrderSelectionView : UIView
/**
 *显示订单选择时间的label
 */
@property (nonatomic,strong)UILabel *timeLabel;
/**
 *显示订单选择折扣的label
 */
@property (nonatomic, strong)UILabel *discountLabel;
@property (nonatomic, assign)id<OrderSelectionViewDelegate>delegate;

@end
