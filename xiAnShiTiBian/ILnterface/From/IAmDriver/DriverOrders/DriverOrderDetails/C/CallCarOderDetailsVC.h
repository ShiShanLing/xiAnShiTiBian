//
//  CallCarOderDetailsVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "BaseViewController.h"

@interface CallCarOderDetailsVC : BaseViewController
/**
 *0 代表未接的订单 1代表 正在运行的订单 2代表 已经完成的订单
 */
@property (nonatomic, assign)NSInteger stateIndex;
/**
 *这个是司机查看自己正在进行的定的ID
 */
@property (nonatomic, strong)NSString *carOwnerId;
/**
 *这个是司机查看某个没有正在进行的订单的ID 用来接单和显示订单使用
 */
@property (nonatomic, strong)NSString *dricerOrderId;
/**
 *这个是用导航到商家和买家地址的经纬度
 */
@property (nonatomic, assign)CLLocationCoordinate2D location2D;
@end
