//
//  DriverDataTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/11.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DriverStateTVCellDelegate <NSObject>
/**
 *下线按钮
 */
- (void)handleOfflineBtn;
/**
 *查看订单
 */
- (void)handleCheckOrderBtn;

@end

/**
 *司机主界面的状态显示
 */
@interface DriverStateTVCell : UITableViewCell

@property (nonatomic, assign)id<DriverStateTVCellDelegate>delegate;

@property (nonatomic, strong)DriverDataModel *model;

@end
