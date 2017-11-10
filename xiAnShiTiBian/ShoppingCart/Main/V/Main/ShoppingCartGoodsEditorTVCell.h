//
//  ShoppingCartGoodsEditorTVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/3/10.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModifyNumberView.h"

@protocol ShoppingCartGoodsEditorTVCellDelegate <NSObject>
/**
 *判断用户选择的是哪一个商家的哪一个商品
 */
- (void)ShoppingCartGoodsSelectedClick:(int)index;
/**
 *判断用户需要删除哪一个商店里面的哪一个商品
 */
-(void)GoodsDeleteEvents:(int)index;
/**
 *判断用户需要编辑的是哪一个cell上的商品
 */
- (void)specEditor:(int)index;
@end

@interface ShoppingCartGoodsEditorTVCell : UITableViewCell <ModifyNumberViewDelegate>
/**
 *选择商品btn
 */
@property (nonatomic, strong) OrderBtn *selectedBtn;
/**
 *商品图片
 */
@property (nonatomic, strong) UIImageView *goodsImage;

/**
 *商品名称
 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
/**
 *规格分类显示
 */
@property (nonatomic, strong) UILabel *specLabel;
/**
 *加减数量
 */
@property (nonatomic, strong) ModifyNumberView *ModifyNumberView;
/**
 *删除商品btn
 */
@property (nonatomic, strong) OrderBtn *deleteBtn;
/**
 *编辑按钮下拉按钮
 */
@property (nonatomic, strong) OrderBtn *dropDownBtn;

@property (nonatomic, assign) BOOL isSelect;

@property (weak, nonatomic) id<ShoppingCartGoodsEditorTVCellDelegate>delegate;

@property (nonatomic, strong) ShoppingCartGoodsModel *model;

/**
 *用来给控制赋值 判断点了那个cell里面的 后者用来告诉cell 你是不是最后一个
 */
- (void)ControlsAssignment:(NSIndexPath *)indexPath subscript:(BOOL)subscript;

@property (nonatomic, strong)UILabel *segmentationLabel;
@end
