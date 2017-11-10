//
//  SOSMTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *商家待付款界面 订单界面货运方式cell
 */
@interface SOSMTVCell : UITableViewCell
- (void)OrderStateBtn:(int)state;

@property (nonatomic, strong)SellerOrderListModel *model;

@end
