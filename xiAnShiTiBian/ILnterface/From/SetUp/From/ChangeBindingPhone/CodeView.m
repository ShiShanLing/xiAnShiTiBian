//
//  CodeView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CodeView.h"

@interface CodeView ()

//倒计时按钮
@property (nonatomic, strong)JKCountDownButton *countdownBtn;
@end

@implementation CodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MColor(255, 255, 255);
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.text = @"验证码";
        titleLabel.font = MFont(kFit(14));
        [self addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self, kFit(12)).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(kFit(50));
        
        self.countdownBtn = [JKCountDownButton new];
        _countdownBtn.titleLabel.font = [UIFont systemFontOfSize:kFit(14)];
        [_countdownBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_countdownBtn setTitleColor:MColor(161, 161, 161) forState:(UIControlStateNormal)];
        [_countdownBtn addTarget:self action:@selector(handleCountdownBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_countdownBtn];
        self.countdownBtn.sd_layout.rightSpaceToView(self, kFit(12)).widthIs(kFit(103)).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
        
        UILabel *segmentationLabel = [UILabel new];
        segmentationLabel.backgroundColor = MColor(161, 161, 161);
        [self addSubview:segmentationLabel];
        segmentationLabel.sd_layout.rightSpaceToView(_countdownBtn, 0).heightIs(kFit(18)).widthIs(kFit(0.5)).centerYEqualToView(self);
        self.CodeTF = [UITextField new];
        _CodeTF.placeholder = @"请输入短信验证码";
        _CodeTF.font = MFont(kFit(14));
        [self addSubview:_CodeTF];
        _CodeTF.sd_layout.leftSpaceToView(titleLabel, kFit(15)).rightSpaceToView(segmentationLabel, kFit(15)).topSpaceToView(self, 0).bottomSpaceToView(self, 0);
    }
    return self;
}
//获取验证码
- (void)handleCountdownBtn:(JKCountDownButton *)sender {
    


    sender.enabled = NO;
    //button type要 设置成custom 否则会闪动
    [sender startWithSecond:60];
    [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
        NSString *title = [NSString stringWithFormat:@"%d秒后可重发",second];
        return title;
    }];
    [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
        countDownButton.enabled = YES;
        return @"点击重新获取";
        
    }];
}//换取验证码

@end
