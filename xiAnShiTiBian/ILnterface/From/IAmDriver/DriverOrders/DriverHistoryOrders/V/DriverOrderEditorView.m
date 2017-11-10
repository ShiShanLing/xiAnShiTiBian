//
//  DriverOrderEditorView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverOrderEditorView.h"


@implementation DriverOrderEditorView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.regionBtn = [UIButton new];
        _regionBtn.titleLabel.font = MFont(kFit(14));
        [_regionBtn setTitle:@"地区: 周边" forState:(UIControlStateNormal)];
        [_regionBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_regionBtn addTarget:self action:@selector(handleRegionChooseBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_regionBtn];
        _regionBtn.sd_layout.leftSpaceToView(self, kFit(12)).centerYEqualToView(self).widthIs(kFit(67)).heightIs(kFit(14));
        
        UIButton *regionChooseBtn = [UIButton new];
        UIImage *regionImage = [UIImage imageNamed:@"dtxiala"];
        regionImage = [regionImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [regionChooseBtn setImage:regionImage forState:(UIControlStateNormal)];
        [regionChooseBtn addTarget:self action:@selector(handleRegionChooseBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:regionChooseBtn];
        regionChooseBtn.sd_layout.leftSpaceToView(_regionBtn, kFit(0)).widthIs(kFit(30)).heightIs(kFit(42)).centerYEqualToView(self);
        
        self.carTypeBtn = [UIButton new];
        _carTypeBtn.titleLabel.font = MFont(kFit(14));
        [_carTypeBtn setTitle:@"地区: 小型面包车" forState:(UIControlStateNormal)];
        CGFloat widht = [self getWidthWithTitle:@"车型: 小型面包车" font:MFont(kFit(14))];
        [_carTypeBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_carTypeBtn addTarget:self action:@selector(handleCarTypeChooseBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_carTypeBtn];
        _carTypeBtn.sd_layout.leftSpaceToView(regionChooseBtn, kFit(20)).centerYEqualToView(self).widthIs(widht).heightIs(kFit(14));
        UIButton *carTypeChooseBtn = [UIButton new];
        UIImage *carTypeImage = [UIImage imageNamed:@"dtxiala"];
        carTypeImage = [carTypeImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [carTypeChooseBtn setImage:carTypeImage forState:(UIControlStateNormal)];
        [carTypeChooseBtn addTarget:self action:@selector(handleCarTypeChooseBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:carTypeChooseBtn];
        carTypeChooseBtn.sd_layout.leftSpaceToView(_carTypeBtn, kFit(0)).widthIs(kFit(30)).heightIs(kFit(42)).centerYEqualToView(self);
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(0.5);
    }
    return self;
}

- (void)ControlsAssignment:(NSString *)str type:(int)type {
    if (type == 0) {
        NSString * textStr = [NSString stringWithFormat:@"地区: %@", str];
       [_regionBtn setTitle:textStr forState:(UIControlStateNormal)];
        
    }else {
        NSString * textStr = [NSString stringWithFormat:@"车型: %@", str];
        CGFloat widht = [self getWidthWithTitle:textStr font:MFont(kFit(14))];
        [_carTypeBtn setTitle:textStr forState:(UIControlStateNormal)];
        _carTypeBtn.sd_layout.widthIs(widht);
    
    }
}
//范围选择
- (void)handleRegionChooseBtn {
    
    
    
    if ([_delegate respondsToSelector:@selector(handleRegionChooseBtn)]) {
        [_delegate handleRegionChooseBtn];
    }
}
//车型选择
- (void)handleCarTypeChooseBtn {
    if ([_delegate respondsToSelector:@selector(handleCarTypeChooseBtn)]) {
        [_delegate handleCarTypeChooseBtn];
    }
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}


@end
