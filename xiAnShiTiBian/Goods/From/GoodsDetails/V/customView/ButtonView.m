//
//  ButtonView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/12.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ButtonView.h"

@implementation ButtonView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1];
        self.iconImage = [UIImageView new];
        [self addSubview:self.iconImage];
        self.iconImage.sd_layout.leftSpaceToView(self, kFit(16.5)).topSpaceToView(self, kFit(10)).widthIs(kFit(17)).autoHeightRatio(1);
        self.titleLabel = [UILabel new];
        [self addSubview:self.titleLabel];
        self.titleLabel.textAlignment = 1;
        self.titleLabel.sd_layout.leftSpaceToView(self, kFit(0)).topSpaceToView(self.iconImage, kFit(6)).bottomSpaceToView(self, kFit(6)).rightSpaceToView(self, kFit(0));
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(operationClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)operationClick:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(CommodityOperating:)]) {
        [_delegate CommodityOperating:self];
    }
}


@end
