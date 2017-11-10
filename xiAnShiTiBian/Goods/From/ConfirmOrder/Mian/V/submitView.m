//
//  submitView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "submitView.h"

@implementation submitView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor orangeColor];
        self.submitBtn = [UIButton new];
        [_submitBtn setTitle:@"提交订单" forState:(UIControlStateNormal)];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _submitBtn.backgroundColor = kNavigation_Color;
        [self addSubview:_submitBtn];
        [_submitBtn addTarget:self action:@selector(handleSubmitBtn) forControlEvents:(UIControlEventTouchUpInside)];
        _submitBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(kFit(152));
        
        self.priceLabel = [UILabel new];
        _priceLabel.backgroundColor = [UIColor whiteColor];
        _priceLabel.text = @"￥3500.00";
        _priceLabel.textAlignment = 1;
        _priceLabel.textColor = [UIColor redColor];
        _priceLabel.font = MFont(kFit(14));
        _priceLabel.numberOfLines = 0;
        [self addSubview:_priceLabel];
        _priceLabel.sd_layout.rightSpaceToView(_submitBtn, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(kFit(100));
        
        UILabel *titleLabel =[UILabel new];
        titleLabel.text = @"合计 :";
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = 2;
        [self addSubview:titleLabel];
        titleLabel.sd_layout.rightSpaceToView(_priceLabel, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0).leftSpaceToView(self, 0);
        
    }
    return self;
}
- (void)handleSubmitBtn {
    if ([_delegate respondsToSelector:@selector(ConfirmpayBtn)]) {
        [_delegate ConfirmpayBtn];
    }

}
@end
