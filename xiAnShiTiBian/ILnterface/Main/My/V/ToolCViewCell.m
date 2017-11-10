//
//  ToolCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ToolCViewCell.h"

@interface ToolCViewCell () <ToolbarViewDelegate>

@end

@implementation ToolCViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    self.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1];
    [self CreatingControls];
    }
    
    return self;
    
}
- (void)CreatingControls {
    self.TitleView = [[ToolTitleView alloc] init];
    _TitleView.titleLabel.text = @"必备工具";
    [self.contentView addSubview:_TitleView];
    _TitleView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(50);
    
    self.toolbarView = [ToolbarView new];
    _toolbarView.Delegate = self;
    [self.contentView addSubview:self.toolbarView];
    self.toolbarView.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(self.TitleView, 0.5).heightIs(120);
    
    
}
- (void)ToolbarChoose:(int)index {
    
    if ([_delegate respondsToSelector:@selector(ToolChoose:)]) {
        [_delegate ToolChoose:index];
    }
}
@end
