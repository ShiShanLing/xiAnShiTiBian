//
//  ToolTitleView.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolFunctionView.h"
/**
 *通用的标签视图 显示每栏的标题
 */
@interface ToolTitleView : UIView

@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *functionLabel;
@property (nonatomic, strong)UIImageView *iconImage;
@end
