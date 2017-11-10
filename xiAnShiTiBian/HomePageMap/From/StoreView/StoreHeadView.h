//
//  StoreHeadView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/2.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreScoreView.h"
/**
 *店铺界面 商店背景
 */
@interface StoreHeadView : UIView
/**
 *商店图片
 */
@property (nonatomic, strong)UIImageView *storeImage;
/**
 *商店头像
 */
@property (nonatomic, strong)UIImageView *userImage;
/**
 *商店名称
 */
@property (nonatomic, strong)UILabel *nameLabel;
/**
 *商店等级
 */
@property (nonatomic, strong)UIImageView *evaluationImage;
/**
 *商家信誉度 1
 */
@property (nonatomic, strong)StoreScoreView *credibilityView;
/**
 *商家信誉度 2
 */
@property (nonatomic, strong)StoreScoreView *credibilityView2;
/**
 *商家信誉度 3
 */
@property (nonatomic, strong)StoreScoreView *credibilityView3;

@property (nonatomic, strong)StoreRankingListModel *model;

@end
