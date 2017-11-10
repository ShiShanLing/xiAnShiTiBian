//
//  ToolFunctionView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ToolFunctionView.h"

@implementation ToolFunctionView

- (instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.iconImage = [[UIImageView alloc] init];
        [self addSubview:self.iconImage];
        _iconImage.sd_layout.leftSpaceToView(self, kFit(30)).rightSpaceToView(self, kFit(30)).topSpaceToView(self, kFit(30)).autoHeightRatio(1.0);
        self.nameLable = [[UILabel alloc] init];
        self.nameLable.textAlignment = 1;
        self.nameLable.font = [UIFont systemFontOfSize:kFit(14)];
        [self addSubview:self.nameLable];
        _nameLable.sd_layout.leftSpaceToView(self, kFit(5)).rightSpaceToView(self, kFit(5)).topSpaceToView(self.iconImage, 0).bottomSpaceToView(self, kFit(20));
        UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)handleTap:(ToolFunctionView *)tap {
    
    if ([_delegate respondsToSelector:@selector(FunctionChoose:)]) {
        [_delegate FunctionChoose:self];
    }
    
}



@end
