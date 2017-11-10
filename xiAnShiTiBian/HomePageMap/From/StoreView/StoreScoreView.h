//
//  StoreScoreView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/2.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *展示商家的各种信誉度
 */
@interface StoreScoreView : UIView
/**
 *信誉类型
 */
@property (nonatomic, strong)UILabel *typeLabel;
/**
 *信誉分数
 */
@property (nonatomic,strong)UILabel *scoreLabel;
/**
 *信誉级别 高,中,低
 */
@property (nonatomic,strong)UILabel *levelLabel;

@end
