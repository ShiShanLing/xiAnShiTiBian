//
//  NewSAVC.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/17.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *新增收货地址  这个界面的处理是这样的  商家的发货地址和 买家的收获的值公用  用 roleStr 来判断  ->>>>>>>.在买家收货地址使用的使用 用 "AddressState" 字段来判断买家是想 添加一个新的收货地址还是想 修改某个收获的地址的信息..在判断要修改某个收货地址的时候 就请求数据(因为收货地址列表的数据里面没有经纬度) 否者相反
 */
@interface NewSAVC : UIViewController
/**
 *商家添加发货地址 和买家添加收货地址公用界面 1代表买家 2代表商家
 */
@property (nonatomic, strong)NSString *roleStr;
/**
 *来判断地址状态 是添加新的 还是编辑旧的  1代表新的 二代表旧的
 */
@property (nonatomic, assign)NSInteger AddressState;

@property (nonatomic, strong)ShippingAddressModel *model;

@property (nonatomic, strong)SellerShipAddressModel *SellerModel;
@end
