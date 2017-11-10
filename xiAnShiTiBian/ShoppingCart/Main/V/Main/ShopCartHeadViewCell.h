//
//  ShopCartHeadViewCell.h
//  meidianjie
//
//  Created by HYS on 16/1/5.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartModel.h"

@class ShopCartHeadViewCell;

@protocol ShopCartHeadViewCellDelegate <NSObject>
/**
 *判断用户点击了那个商店  是选择还是反选
 */
- (void)shopCartStoreSelectedClick:(int)index state:(BOOL)state;
/**
 *判断是要开始编辑商品还是完成编辑
 */
- (void)ShopGoodsEditor:(int)index state:(BOOL)state;

@end

@interface ShopCartHeadViewCell : UITableViewCell
/**店铺全选btn*/
@property (nonatomic, strong) UIButton *selectedBtn;
/**店铺小图标*/
@property (nonatomic, strong) UIImageView *shopIcon;
/**店铺名称*/
@property (nonatomic, strong) UILabel *shopNameLabel;
/**编辑*/
@property (nonatomic, strong) UIButton * editorBtn;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, strong) ShoppingCartStoreModel *model;
@property (weak, nonatomic) id<ShopCartHeadViewCellDelegate> delegate;

- (void)ControlsAssignment:(NSIndexPath *)indexPath;

@end
