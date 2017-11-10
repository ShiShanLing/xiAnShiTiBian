//
//  ToolCViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolTitleView.h"
#import "ToolbarView.h"
#import "ToolFunctionView.h"//控制按钮

@protocol ToolCViewCellDelegate <NSObject>

-(void)ToolChoose:(int)index;

@end

/**
 *我的界面第二个cell
 */
@interface ToolCViewCell : UICollectionViewCell

@property (nonatomic, strong)ToolTitleView *TitleView;

@property (nonatomic, strong)ToolbarView *toolbarView;

@property (nonatomic, assign)id<ToolCViewCellDelegate>delegate;

@end
