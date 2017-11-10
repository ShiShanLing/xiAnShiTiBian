//
//  ConfirmOrderVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "BaseViewController.h"
/**
 *确认订单界面
 */
@interface ConfirmOrderVC : BaseViewController
//购物车ID
@property (nonatomic, strong) NSString *cartIds;
/**
 *选择的商品价格
 */
@property (nonatomic, assign) CGFloat orderPrice;

- (void)ControlsAssignment:(int)index;

@end
