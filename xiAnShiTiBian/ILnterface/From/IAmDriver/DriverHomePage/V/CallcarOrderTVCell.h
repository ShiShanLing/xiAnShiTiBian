//
//  CallcarOrderTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CallcarOrderTVCellDelegate <NSObject>
/**
 *接单按钮
 */
- (void)handleReceiveOrderBtn:(UIButton *)sender;
/**
 *订单详情
 */
- (void)handleOrderDetailsBtn:(UIButton *)sender;

@end
/**
 *展示叫车订单的简介.
 */
@interface CallcarOrderTVCell : UITableViewCell

@property(nonatomic, assign)id<CallcarOrderTVCellDelegate>delegate;

@property (nonatomic, strong)DriverCarOrderModel *model;

- (void)completedOrder;

- (void)ButtonAssignment:(NSIndexPath *)indexPath;
@end
