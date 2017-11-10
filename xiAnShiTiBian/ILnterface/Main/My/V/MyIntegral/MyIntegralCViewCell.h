//
//  MyIntegralCViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolTitleView.h"

#import "IntegralBarView.h"
#import "ToolFunctionView.h"//控制按钮

@protocol MyIntegralCViewCellDelegate <NSObject>

-(void)MyIntegraChoose:(int)index;

@end


/**
 *积分cell
 */
@interface MyIntegralCViewCell : UICollectionViewCell
@property (nonatomic, strong)ToolTitleView *TitleView;

@property (nonatomic, strong)IntegralBarView *integralBarView;
@property (nonatomic, assign)id<MyIntegralCViewCellDelegate>delegate;

@end
