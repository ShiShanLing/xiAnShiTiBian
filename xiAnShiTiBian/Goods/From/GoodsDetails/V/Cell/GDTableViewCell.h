//
//  GDTableViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/9.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SZCirculationImageView.h" //轮播图对象
/**
 *商品详情介绍
 */
@interface GDTableViewCell : UITableViewCell

@property(nonatomic, strong)UIView *blankLabel;
/**
 *存放展示商品图片的数组
 */
@property (nonatomic, strong)NSMutableArray *ImageArray;
/**
 *商品名称
 */
@property (nonatomic, strong)UILabel *goodsName;
/**
 *商品原价
 */
@property (nonatomic, strong)UILabel *goodsOPrice;
/**
 *商品现价
 */
@property (nonatomic, strong)UILabel *goodsPPrice;
/**
 *多少人购买
 */
@property (nonatomic, strong)UILabel *GoodsPeopleBuy;
/**
 *送多少积分
 */
@property (nonatomic, strong)UILabel *GoodsAwardPoints;

- (void)GoodsImageAssignment:(GoodsDetailsModel *)model;

@end
