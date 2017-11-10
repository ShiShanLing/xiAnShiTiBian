//
//  OrderSelectionView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderSelectionView.h"

@implementation OrderSelectionView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MColor(238, 238, 238);
        /**
         *由两部分组成 上面的view 下面的view
         */
        UIView *topView = [UIView new];
        topView.backgroundColor = [UIColor whiteColor];
        [self addSubview:topView];
        topView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(kFit(48));
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"订单时间";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(14));
        [topView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(topView, kFit(12)).centerYEqualToView(topView).widthIs(kFit(100)).heightIs(kFit(14));

        UIButton *arrowBtn = [UIButton new];
        UIImage *arrowImage = [UIImage imageNamed:@"qbddjt"];
        arrowImage = [arrowImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [arrowBtn setImage:arrowImage forState:(UIControlStateNormal)];
        [arrowBtn addTarget:self action:@selector(handleOrderTime) forControlEvents:(UIControlEventTouchUpInside)];
        [topView addSubview:arrowBtn];
        arrowBtn.sd_layout.rightSpaceToView(topView, kFit(0)).heightIs(kFit(50)).widthIs(kFit(40)).centerYEqualToView(topView);

        self.timeLabel =[UILabel new];
        _timeLabel.textColor = MColor(134, 134, 134);
        _timeLabel.font = MFont(kFit(14));
        _timeLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOrderTime)];
        [_timeLabel addGestureRecognizer:tap];
        _timeLabel.text = @"全部订单";
        _timeLabel.textAlignment = 2;
        UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOrderTime)];
        [_timeLabel addGestureRecognizer:timeTap];
        
        [topView addSubview:_timeLabel];
        _timeLabel.sd_layout.leftSpaceToView(titleLabel, kFit(12)).centerYEqualToView(topView).rightSpaceToView(arrowBtn, kFit(5)).heightIs(kFit(48));
        /////---------------------------------------
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bottomView];
        bottomView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(topView, kFit(0.5)).rightSpaceToView(self, 0).heightIs(kFit(42));
        
        UIButton *discountBtn = [UIButton new];
        [discountBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        discountBtn.titleLabel.font = MFont(kFit(12));
        [discountBtn setTitle:@"折扣" forState:(UIControlStateNormal)];
        UIImage *discounImage = [UIImage imageNamed:@"dtxiala"];
        discounImage = [discounImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [discountBtn setImage:discounImage forState:(UIControlStateNormal)];
        discountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, kFit(25));
        discountBtn.imageEdgeInsets = UIEdgeInsetsMake(0, kFit(40), 0, 0);
        [discountBtn addTarget:self action:@selector(handleDiscountBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [bottomView addSubview:discountBtn];
        discountBtn.sd_layout.leftSpaceToView(bottomView, kFit(0)).widthIs(kFit(63)).heightIs(kFit(42)).topSpaceToView(bottomView, 0);
        
        self.discountLabel = [UILabel new];
        _discountLabel.text = @"全部";
        _discountLabel.font = MFont(kFit(12));
        _discountLabel.textColor = MColor(255, 48, 48);
        _discountLabel.textAlignment = 1;
        _discountLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *discountTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDiscountBtn)];
        [self.discountLabel addGestureRecognizer:discountTap];
        [bottomView addSubview:_discountLabel];
        _discountLabel.sd_layout.leftSpaceToView(discountBtn, kFit(0)).widthIs(kFit(40)).heightIs(kFit(42)).topSpaceToView(bottomView, 0);
    }
    return self;
}
- (void)handleDiscountBtn {
    
    if ([_delegate respondsToSelector:@selector(SelectDiscount)]) {
        [_delegate SelectDiscount];
    }

}
- (void)handleOrderTime {

    if ([_delegate respondsToSelector:@selector(SelectOrderTime)]) {
        [_delegate SelectOrderTime];
    }

}
@end
