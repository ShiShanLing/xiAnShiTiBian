//
//  ToolbarView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToolbarViewDelegate <NSObject>

- (void)ToolbarChoose:(int)index;

@end

#import "ToolFunctionView.h"
/**
 *必备工具所需的按钮
 */
@interface ToolbarView : UIView
@property (nonatomic, assign)id<ToolbarViewDelegate>Delegate;

@end
