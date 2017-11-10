//
//  AllGoodsTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/5.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *店铺横向cell
 */
@interface AllGoodsTVCell : UITableViewCell
/**
 *展示商品的图片
 */
@property (nonatomic, strong)UIImageView *showImage;
/**
 *商品名称
 */
@property (nonatomic, strong)UILabel *nameLabel;
/**
 *商品价格
 */
@property (nonatomic, strong)UILabel *priceLabel;
/**
 *原价钱
 */
@property (nonatomic, strong)UILabel *originalPriceLabel;
/**
 *送多少积分
 */
@property (nonatomic, strong)UILabel *AwardPointsLabel;
/**
 *多少人购买 (热度)
 */
@property (nonatomic, strong)UILabel *heatLabel;

@property (nonatomic, strong)GoodsDetailsModel *model;
@end
