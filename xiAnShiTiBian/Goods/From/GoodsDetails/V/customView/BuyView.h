//
//  BuyView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/12.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAmBusinView.h"
#import "ButtonView.h"

@protocol BuyViewDelegate <NSObject>

- (void)buyViewClick:(NSInteger)index;

@end

@interface BuyView : UIView <ButtonViewDelegate>
/**
 *Customer service telephone 的缩写 客服电话
 */
@property (nonatomic, strong)ButtonView *CSTView;
/**
 *店铺
 */
@property (nonatomic, strong)ButtonView *storeView;
/**
 *收藏
 */
@property (nonatomic, strong)ButtonView *collectionView;
/**
 *加入购物车
 */
@property (nonatomic, strong)UIButton *AddCartBtn;
/**
 *立即购买
 */
@property (nonatomic, strong)UIButton *BuyNowBtn;

@property (nonatomic, assign)id<BuyViewDelegate>delegate;

@end
