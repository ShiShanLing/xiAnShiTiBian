//
//  IRTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/15.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntegralListModel;

/**
 *积分记录cell
 */
@interface IRTVCell : UITableViewCell
/**
 *消费所在的商店名字
 */
@property (nonatomic, strong)UILabel *StoreName;
/**
 *商品图片
 */
@property (nonatomic, strong)UIImageView *StoreImage;
/**
 *提现金额
 */
@property (nonatomic, strong)UILabel *GoodsName;
/**
 *所送积分
 */
@property (nonatomic, strong)UILabel *IntegralNumber;
/**
 *积分说明
 */
@property (nonatomic, strong)UILabel *instructionsLabel;

/**
 *积分类型 使用积分 有两种 1.提现 2.购买商品 获得积分就一种
 */
- (void)IntegralType:(NSDictionary *)describe type:(int)type;
/**
 *
 */
@property (nonatomic, strong)IntegralListModel *model;

@end
