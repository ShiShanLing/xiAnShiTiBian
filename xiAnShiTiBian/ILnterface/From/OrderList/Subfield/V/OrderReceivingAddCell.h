//
//  OrderReceivingAddCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReceivingAddCell : UITableViewCell
/**
 *收货人
 */
@property (nonatomic, strong)UILabel *consigneeLabel;
/**
 *收货人手机号
 */
@property (nonatomic, strong)UILabel *telephoneLabel;
/**
 *收货地址
 */
@property (nonatomic, strong)UILabel *addressLabel;
/**
 *详情地址
 */
@property (nonatomic, strong)UILabel *detailsLabel;

@end
