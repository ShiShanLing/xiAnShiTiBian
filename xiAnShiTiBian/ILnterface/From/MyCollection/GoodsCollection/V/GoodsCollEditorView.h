//
//  GoodsCollEditorView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/7.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsCollEditorView;
@protocol GoodsCollEditorViewDelegate <NSObject>
/**
 *删除收藏的商品
 */
- (void)deleteBtnClick:(GoodsCollEditorView *)view;
/**
 *进入商店
 */
- (void)EnterShopBtnClick:(GoodsCollEditorView *)view;
/**
 *取消
 */
- (void)cancelBtnClick;

@end

/**
 *收藏商品编辑
 */
@interface GoodsCollEditorView : UIView

@property (nonatomic, assign)id<GoodsCollEditorViewDelegate>delegate;

- (void)pop_upAssignment:(NSString *)str;

@end
