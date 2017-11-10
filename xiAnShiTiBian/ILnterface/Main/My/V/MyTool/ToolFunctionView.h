//
//  ToolFunctionView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//
//
#import <UIKit/UIKit.h>
@class ToolFunctionView;
@protocol ToolFunctionViewDelegate <NSObject>

- (void)FunctionChoose:(ToolFunctionView *)view;

@end
/**
 *工具栏图标View
 */
@interface ToolFunctionView : UIView

@property (nonatomic, strong)UIImageView *iconImage;
@property (nonatomic, strong)UILabel *nameLable;
@property (nonatomic, assign)id<ToolFunctionViewDelegate>delegate;

@end
