//
//  OrderEmptyCVCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderEmptyCVCell : UICollectionViewCell

/**
 *提示文字
 */
@property (nonatomic, strong) UILabel * titleLabel;
/**
 *副标题
 */
@property (nonatomic, strong)UILabel *subheadLabel;
/**
 *页面状态
 */
@property (nonatomic, strong)UIImageView *stateImage;

@end
