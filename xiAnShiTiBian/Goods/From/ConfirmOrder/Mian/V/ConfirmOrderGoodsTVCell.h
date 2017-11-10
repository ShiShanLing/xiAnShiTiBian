//
//  ConfirmOrderGoodsTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//
#import <UIKit/UIKit.h>
/**
 *确认订单商品展示cell --->注释掉的控件是UI设计出来的但是暂时不用的
 */
@interface ConfirmOrderGoodsTVCell : UITableViewCell

/**商品图片*/
@property (nonatomic, strong) UIImageView *goodsImage;
/**商品名称 可以两行*/
@property (nonatomic, strong) UILabel *goodNameLabel;
/**颜色分类*/
@property (nonatomic, strong) UILabel *colorLabel;
/**分类*/
@property (nonatomic, strong) UILabel *typeLabel;
/**现在价格*/
@property (nonatomic, strong) UILabel *nowPriceLabel;
/**原价*/
@property (nonatomic, strong) UILabel *oldPriceLabel;
/**商品数量*/
@property (nonatomic, strong) UILabel *goodCountLabel;
/**
 *商品展示model
 */
@property (nonatomic, strong)ShoppingCartGoodsModel *model;
/**
 *商品详情model
 */
@end
