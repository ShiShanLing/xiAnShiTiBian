//
//  ShoppingCartGoodsTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/8.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"
#import "ModifyNumberView.h"
/**
 *购物车内的商品cell 未编辑时
 */
@class ShoppingCartGoodsTVCell;
@protocol ShoppingCartGoodsTVCellDelegate <NSObject>
/**
 *判断用户选择的是哪一个商家的哪一个商品
 */
- (void)ShoppingCartGoodsSelectedClick:(int)index;

@end

@interface ShoppingCartGoodsTVCell : UITableViewCell

/**选择商品btn*/
@property (nonatomic, strong) UIButton *selectedBtn;
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
 *加减数量
 */
@property (nonatomic, strong) ModifyNumberView *ModifyNumberView;


/**商品数量*/
@property (nonatomic, assign) NSInteger goodCount;
/**删除商品*/
@property (nonatomic, strong) UIButton *deleteBtn;

@property (nonatomic, assign) BOOL isSelect;

@property (weak, nonatomic) id<ShoppingCartGoodsTVCellDelegate>delegate;

@property (nonatomic, strong) ShoppingCartGoodsModel *model;

/**
 *用来给控制赋值 判断点了那个cell里面的 后者用来告诉cell 你是不是最后一个来指定下面的label什么颜色 高度
 */
- (void)ControlsAssignment:(NSIndexPath *)indexPath  subscript:(BOOL)subscript;

@property (nonatomic, strong)UILabel *segmentationLabel;

@end
