//
//  OrderBtn.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/11.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBtn : UIButton
/**
 *记录订单的状态 0 取消订单 1支付未付款订单 2已付款已发货 3订单完成未评价 4订单完成已评价
 */
@property (nonatomic, assign)int OrderType;
/**
 *记录按钮在第几个cell上面
 */
@property (nonatomic, strong)NSIndexPath *indexPath;
/**
 *选择规格的时候选择的规格值
 */
@property (nonatomic, strong)NSString *tyepID;
/**
 *选择规格的时候选择的规格名字
 */
@property (nonatomic, strong)NSString *tyepName;

@end
