//
//  ConfirmShippingAddressTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *确认收货地址cell
 */
@interface ConfirmShippingAddressTVCell : UITableViewCell
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

@property (nonatomic, strong)ShippingAddressModel *model;

@end


