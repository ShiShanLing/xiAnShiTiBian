//
//  CitySelectionView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapCitySelectionView.h"

@interface MapCitySelectionView ()



@end

@implementation MapCitySelectionView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        self.citySearchLabel = [UILabel new];
        _citySearchLabel.textAlignment = 1;
        _citySearchLabel.text = @"北京哈撒给";
        _citySearchLabel.font = [UIFont systemFontOfSize:kFit(14)];
        _citySearchLabel.textColor = MColor(168, 168, 168);
        [self addSubview:_citySearchLabel];
        _citySearchLabel.sd_layout.leftSpaceToView(self,kFit(0)).topSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self,kFit(12));
        
        UIButton *drop_downBtn = [UIButton new];
        [drop_downBtn setImage:[UIImage imageNamed:@"dtxiala"] forState:(UIControlStateNormal)];
        [self addSubview:drop_downBtn];
        drop_downBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(kFit(16));
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(CitySelectionClick)]) {
        [_delegate CitySelectionClick];
    }
    
}
@end
