//
//  DriverTheRunningOrderTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DriverTheROTVCellDelegate <NSObject>
/**
 *使用导航
 */
- (void)navigation:(OrderBtn *)sender;
/**
 *确认送达
 */
- (void)ConfirmDelivery:(OrderBtn *)sender;
@end
/**
 *DriverTheRunningOrderTableViewCell 的缩写  司机正在运行的订单
 */
@interface DriverTheROTVCell : UITableViewCell

@property (nonatomic, strong)DriverCarOrderModel *model;

@property (nonatomic,assign)id<DriverTheROTVCellDelegate>delegate;

@end
