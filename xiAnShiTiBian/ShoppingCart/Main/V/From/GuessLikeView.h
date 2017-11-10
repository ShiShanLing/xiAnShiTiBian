//
//  GuessLikeView.h
//  meidianjie
//
//  Created by HYS on 16/2/22.
//  Copyright © 2016年 HYS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GuessLikeGoodsModel.h"
@class GuessLikeView;
@protocol GuessLikeViewDelegate <NSObject>

- (void)viewClick:(GuessLikeView *)tap;

@end

@interface GuessLikeView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) GuessLikeGoodsModel *likeGoodsModel;
@property (nonatomic, strong) UIImageView *goodsImage;
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@property (nonatomic, strong) UILabel *goodsPrice;
@property (nonatomic, strong) UIButton *searchBtn;
/**
 *
 */
@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, assign)id<GuessLikeViewDelegate>delegate;

- (void)assignment:(NSString *)url;

@end
