//
//  BuyView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/12.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "BuyView.h"

@implementation BuyView

///**
// *Customer service telephone 的缩写 客服电话
// */
//@property (nonatomic, strong)IAmBusinView *CSTView;
///**
// *店铺
// */
//@property (nonatomic, strong)IAmBusinView *storeView;
///**
// *收藏
// */
//@property (nonatomic, strong)IAmBusinView *collectionView;
///**
// *加入购物车
// */
//@property (nonatomic, strong)UIButton *AddCartBtn;
///**
// *立即购买
// */
//@property (nonatomic, strong)UIButton *BuyNowBtn;
-(instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
        [self setCreatingControls];
    }
    return self;
}
- (void)setCreatingControls {
    
    self.CSTView = [ButtonView new];
    _CSTView.delegate = self;
    _CSTView.iconImage.image = [UIImage imageNamed:@"kf"];
    _CSTView.titleLabel.text = @"客服";
    _CSTView.tag = 191;
    _CSTView.titleLabel.textColor = MColor(134, 134, 134);
    _CSTView.titleLabel.font = MFont(kFit(10));
    [self addSubview:_CSTView];
    self.CSTView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(kFit(50)).autoHeightRatio(1);
    
    UILabel *label1 = [UILabel new];
    label1.backgroundColor = MColor(210, 210, 210);
    [self addSubview:label1];
    label1.sd_layout.leftSpaceToView(_CSTView, 0).topSpaceToView(self , 0).bottomSpaceToView(self, 0).widthIs(0.5);
    
    self.storeView = [ButtonView new];
    _storeView.delegate = self;
    _storeView.tag = 192;
    _storeView.iconImage.image = [UIImage imageNamed:@"dp"];
    _storeView.titleLabel.text = @"店铺";
    _storeView.titleLabel.textColor = MColor(134, 134, 134);
    _storeView.titleLabel.font = MFont(kFit(10));
    [self addSubview:_storeView];
    self.storeView.sd_layout.leftSpaceToView(label1, 0).topSpaceToView(self, 0).widthIs(kFit(50)).autoHeightRatio(1);
    
    UILabel *label2 = [UILabel new];
    label2.backgroundColor = MColor(210, 210, 210);
    [self addSubview:label2];
    label2.sd_layout.leftSpaceToView(_storeView, 0).topSpaceToView(self , 0).bottomSpaceToView(self, 0).widthIs(0.5);

    
    self.collectionView = [ButtonView new];
    _collectionView.delegate = self;
    _collectionView.tag = 193;
    _collectionView.iconImage.image = [UIImage imageNamed:@"scq"];
    _collectionView.titleLabel.text = @"收藏";
    _collectionView.titleLabel.textColor = MColor(134, 134, 134);
    _collectionView.titleLabel.font = MFont(kFit(10));
    [self addSubview:_collectionView];
    self.collectionView.sd_layout.leftSpaceToView(label2, 0).topSpaceToView(self, 0).widthIs(kFit(50)).autoHeightRatio(1);
    
    CGFloat widht = (kScreen_widht - (kFit(50) * 3)) / 2;
    
    self.AddCartBtn = [UIButton new];
    _AddCartBtn.tag = 194;
    _AddCartBtn.backgroundColor = MColor(242, 137, 137);
    _AddCartBtn.font = MFont(kFit(15));
    [_AddCartBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_AddCartBtn setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    [_AddCartBtn addTarget:self action:@selector(handleAddBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_AddCartBtn];
    self.AddCartBtn.sd_layout.leftSpaceToView(self.collectionView, 0).topSpaceToView(self, 0).widthIs(widht).heightIs(kFit(50));
    
    self.BuyNowBtn = [UIButton new];
    _BuyNowBtn.tag = 195;
    _BuyNowBtn.backgroundColor = kNavigation_Color;
    _BuyNowBtn.font = MFont(kFit(15));
    [_AddCartBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_BuyNowBtn setTitle:@"立即购买" forState:(UIControlStateNormal)];
    [self addSubview:_BuyNowBtn];
     self.BuyNowBtn.sd_layout.leftSpaceToView(self.AddCartBtn, 0).topSpaceToView(self, 0).widthIs(widht).heightIs(kFit(50));
    [_BuyNowBtn addTarget:self action:@selector(handleAddBtn:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (void)handleAddBtn:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(buyViewClick:)]) {
        [_delegate buyViewClick:sender.tag];
    }
}

- (void)CommodityOperating:(ButtonView *)view {
    
    if ([_delegate respondsToSelector:@selector(buyViewClick:)]) {
        [_delegate buyViewClick:view.tag];
        
    }
  
    
}
@end
