//
//  GoodsShowCViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/1.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *竖向滑动的商品展示
 */
@interface GoodsShowCViewCell : UICollectionViewCell
/**
 *商品图片
 */
@property (nonatomic, strong)UIImageView *goodsImage;
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

- (void)configureCellWithPostURL:(NSString *)posterURL;

@property (nonatomic, strong)GoodsDetailsModel *model;

@end
