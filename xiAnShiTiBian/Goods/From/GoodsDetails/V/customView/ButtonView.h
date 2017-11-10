//
//  ButtonView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/12.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ButtonView;
@protocol ButtonViewDelegate <NSObject>
/**
 *商品操作 收藏,打电话给商家 进入店铺的操作
 */
- (void)CommodityOperating:(ButtonView *)view;

@end

/**
 *模拟上图标下面标题的UIBUtton
 */
@interface ButtonView : UIView

@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, assign)id<ButtonViewDelegate>delegate;

@end
