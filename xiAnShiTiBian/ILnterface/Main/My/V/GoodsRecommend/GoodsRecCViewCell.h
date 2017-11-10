//
//  GoodsRecCViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/1.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsDetailsModel;
/**
 *公用的商品推荐模块
 */
@interface GoodsRecCViewCell : UICollectionViewCell
/**
 *商品图片
 */
@property (nonatomic, strong)UIImageView *goodsImage;
/**
 *商品名称
 */
@property (nonatomic, strong)UILabel *goodsName;
/**
 *商品价格
 */
@property (nonatomic, strong)UILabel *goodsPrice;
/**
 *搜索相似的商品
 */
@property (nonatomic, strong)UIButton *searchBtn;
/**
 *商品详情model
 */
@property (nonatomic, strong)GoodsDetailsModel *model;

@end
