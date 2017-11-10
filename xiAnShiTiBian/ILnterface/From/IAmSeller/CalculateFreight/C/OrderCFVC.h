//
//  OrderCFVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *根据订单计算运费的界面
 */
@interface OrderCFVC : UIViewController
/**
 *
 */
@property (nonatomic, strong)ShippingAddressModel *buyersModel;
/**
 *订单Sn
 */
@property (nonatomic, strong)NSString *OrderSn;

@end
