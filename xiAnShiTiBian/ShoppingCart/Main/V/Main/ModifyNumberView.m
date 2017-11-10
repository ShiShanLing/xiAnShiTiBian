//
//  ModifyNumberView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/9.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ModifyNumberView.h"

@implementation ModifyNumberView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
      //  NSLog(@"<><><><><><><><><><><><><><><><><><><><>%f", frame.size.height);
        
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        
        self.reductionBtn= [UIButton new];
      
        [_reductionBtn setImage:[UIImage imageNamed:@"sljj"] forState:(UIControlStateNormal)];
        _reductionBtn.tag = 201;
        [_reductionBtn addTarget:self action:@selector(handleNumberEditor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_reductionBtn];
        
        _reductionBtn.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(frame.size.height);
        
        self.AddBtn = [UIButton new];
        [_AddBtn setImage:[UIImage imageNamed:@"slj"] forState:(UIControlStateNormal)];
        _AddBtn.tag = 202;
       [_AddBtn addTarget:self action:@selector(handleNumberEditor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_AddBtn];
        _AddBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(frame.size.height);
        
        self.numberTF = [UITextField new];
        _numberTF.userInteractionEnabled  = NO;
        _numberTF.text = @"1";
        _numberTF.layer.borderWidth = 0.5;
        _numberTF.layer.borderColor = [[UIColor blackColor] CGColor];
        _numberTF.textAlignment = 1;
        _numberTF.textColor = MColor(134, 134, 134);
        [self addSubview:_numberTF];
        _numberTF.sd_layout.leftSpaceToView(_reductionBtn, 1).topSpaceToView(self, 0).rightSpaceToView(_AddBtn, 1).bottomSpaceToView(self, 0);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GoodsNumberEditorClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)GoodsNumberEditorClick:(UITapGestureRecognizer *)tap {

    if ([_delegate respondsToSelector:@selector(GoodsNumberEditorClickTag:)]) {
        [_delegate GoodsNumberEditorClickTag:tap];
    }
}

- (void)handleNumberEditor:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(GoodsNumberChange:view:)]) {
        [_delegate GoodsNumberChange:sender view:self];
    }


}

@end
