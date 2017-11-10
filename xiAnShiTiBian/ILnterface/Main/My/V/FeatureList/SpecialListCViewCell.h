//
//  SpecialListCViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAmBusinView.h"

@protocol SpecialListCViewCellDelegate <NSObject>
/**
 *管理点击事件 我是车主 我是商家 客服 的共同响应事件
 */
- (void)managementFunctionClick:(int)index;

@end

@interface SpecialListCViewCell : UICollectionViewCell

@property (nonatomic, assign)id<SpecialListCViewCellDelegate>delegate;
@end
