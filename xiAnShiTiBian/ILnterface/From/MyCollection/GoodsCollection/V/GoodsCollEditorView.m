//
//  GoodsCollEditorView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/7.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "GoodsCollEditorView.h"

@interface GoodsCollEditorView ()

@property (nonatomic, strong)UILabel *EnterLabel;

@end

@implementation GoodsCollEditorView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MColor(238, 238, 238);
        UIButton *deleteBtn  = [UIButton new];
        deleteBtn.layer.cornerRadius = 3;
        deleteBtn.layer.masksToBounds = YES;
        UIImage *deleteimage = [UIImage imageNamed:@"scbb-qxsc"];
        //[tapButton setImage:buttonimage forState:(UIControlStateNormal)];
        //设置图像渲染方式
        deleteimage = [deleteimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
        [deleteBtn setImage:deleteimage forState:(UIControlStateNormal)];
        deleteBtn.backgroundColor = [UIColor whiteColor];
        [deleteBtn addTarget:self action:@selector(handleDeleteBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:deleteBtn];
        deleteBtn.sd_layout.leftSpaceToView(self, kFit(113.5)).topSpaceToView(self, kFit(14)).widthIs(kFit(45)).heightIs(kFit(45));
        
        UILabel *deleteLabel = [UILabel new];
        deleteLabel.text = @"取消收藏";
        deleteLabel.textAlignment = 1;
        deleteLabel.font = MFont(kFit(12));
        
        [self addSubview:deleteLabel];
        deleteLabel.sd_layout.centerXEqualToView(deleteBtn).widthIs(kFit(100)).heightIs(kFit(12)).topSpaceToView(deleteBtn, kFit(10));
        
        UIButton *EnterBtn = [UIButton new];
        EnterBtn.layer.cornerRadius = 3;
        EnterBtn.layer.masksToBounds = YES;
        UIImage *Enterimage = [UIImage imageNamed:@"scbb"];
        //[tapButton setImage:buttonimage forState:(UIControlStateNormal)];
        //设置图像渲染方式
        Enterimage = [Enterimage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];//去掉UIButton的渲染色
        [EnterBtn setImage:Enterimage forState:(UIControlStateNormal)];
        EnterBtn.backgroundColor = [UIColor whiteColor];
        [EnterBtn addTarget:self action:@selector(handleEnterBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:EnterBtn];
         EnterBtn.sd_layout.rightSpaceToView(self, kFit(113.5)).topSpaceToView(self, kFit(14)).widthIs(kFit(45)).heightIs(kFit(45));
        
        self.EnterLabel = [UILabel new];
        _EnterLabel.text = @"进入商店";
        _EnterLabel.textAlignment = 1;
        _EnterLabel.font = MFont(kFit(12));
        [self addSubview:_EnterLabel];
        _EnterLabel.sd_layout.centerXEqualToView(EnterBtn).widthIs(kFit(100)).heightIs(kFit(12)).topSpaceToView(EnterBtn, kFit(10));
        
        UIButton *cancelBtn = [UIButton new];
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [cancelBtn setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        cancelBtn.titleLabel.font = MFont(kFit(15));
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn addTarget:self action:@selector(handleCancelBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cancelBtn];
        
        cancelBtn.sd_layout.leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(kFit(50));
    }
    return self;
}

//删除
- (void)handleDeleteBtn {

    if ([_delegate respondsToSelector:@selector(deleteBtnClick:)]) {
        [_delegate deleteBtnClick:self];
    }
    
}
//进入商店
- (void)handleEnterBtn {
    if ([_delegate respondsToSelector:@selector(EnterShopBtnClick:)]) {
        [_delegate EnterShopBtnClick:self];
    }

}
//取消
- (void)handleCancelBtn {
    
    if ([_delegate respondsToSelector:@selector(cancelBtnClick)]) {
        [_delegate cancelBtnClick];
    }

}

- (void)pop_upAssignment:(NSString *)str {

_EnterLabel.text = @"查看商品";

}

@end
