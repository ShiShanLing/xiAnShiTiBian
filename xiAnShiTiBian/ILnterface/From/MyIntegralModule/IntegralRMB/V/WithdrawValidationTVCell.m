//
//  WithdrawValidationTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/6/8.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "WithdrawValidationTVCell.h"

@implementation WithdrawValidationTVCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
      
            }
    return self;
}
-(void)layoutSubviews {
    
    self.GetVerificationCodeBtn.layer.cornerRadius = 6;
    self.GetVerificationCodeBtn.layer.masksToBounds = YES;
    [_GetVerificationCodeBtn.layer setBorderWidth:1.0]; //边框宽度
    _GetVerificationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _GetVerificationCodeBtn.layer.borderColor= [UIColor colorWithRed:242/256.0 green:48/256.0 blue:48/256.0 alpha:1].CGColor;
    _GetVerificationCodeBtn.font = MFont(kFit(10));
    [_GetVerificationCodeBtn setTitleColor:MColor(242, 48, 48) forState:(UIControlStateNormal)];
    [_GetVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];

}
- (IBAction)handleGetVerificationCode:(JKCountDownButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(handleGetVerificationCode:)]) {
        [_delegate handleGetVerificationCode:sender];
        
    }
    
    
    
}

@end
