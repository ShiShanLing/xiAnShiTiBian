//
//  MyIntegralCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/30.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MyIntegralCViewCell.h"

@interface MyIntegralCViewCell ()<IntegralBarViewDelegate>

@end

@implementation MyIntegralCViewCell

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
    _TitleView.titleLabel.text = @"我的积分";
    // _TitleView.functionLabel.text = @"查看更多工具";
    // _TitleView.iconImage.image = [UIImage imageNamed:@"jt"];
    [self.contentView addSubview:_TitleView];
    _TitleView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(50);
    
    self.integralBarView = [IntegralBarView new];
    _integralBarView.Delegate = self;
    [self.contentView addSubview:self.integralBarView];
    self.integralBarView.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(self.TitleView, 0.5).heightIs(120);
    
}

- (void)IntegralBarChoose:(int)index {

    if ([_delegate respondsToSelector:@selector(MyIntegraChoose:)]) {
        
        [_delegate MyIntegraChoose:index];
        
    }

}

@end
