//
//  MapSearchView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapSearchView.h"


#define kTitle_Color  MColor(161, 161, 161)
@interface MapSearchView ()<UITextFieldDelegate>



@end

@implementation MapSearchView



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        UIView *backgroundView = [UIView new];
        backgroundView.layer.cornerRadius = 3;
        backgroundView.layer.masksToBounds = YES;
        backgroundView.backgroundColor = MColor(238, 238, 238);
        [self addSubview:backgroundView];
        backgroundView.sd_layout.leftSpaceToView(self, kFit(12)).topSpaceToView(self, 22).heightIs(kFit(34)).widthIs(kFit(311));
        
        UIButton *searchBtn = [UIButton new];
        [searchBtn setImage:[UIImage imageNamed:@"GoodsSearch"] forState:(UIControlStateNormal)];
        [backgroundView addSubview:searchBtn];
        searchBtn.sd_layout.leftSpaceToView(backgroundView, kFit(5)).topSpaceToView(backgroundView, 0).widthIs(18).bottomSpaceToView(backgroundView, 0);
        
        self.searchTF = [UITextField new];
        _searchTF.returnKeyType = UIReturnKeySearch;
        _searchTF.placeholder = @"请输入";
        _searchTF.font = [UIFont systemFontOfSize:kFit(14)];
        _searchTF.textColor = [UIColor blackColor];
        [backgroundView addSubview:_searchTF];
        _searchTF.sd_layout.leftSpaceToView(searchBtn, kFit(11)).topSpaceToView(backgroundView, 0).bottomSpaceToView(backgroundView,0).rightSpaceToView(backgroundView, 0);
        
        self.cancelBtn = [UIButton new];
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kFit(15)];
        [_cancelBtn addTarget:self action:@selector(handleCancelBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_cancelBtn];
        _cancelBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, kFit(22)).heightIs(kFit(34)).leftSpaceToView(backgroundView, 0);
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(161, 161, 161);
        [self addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self, kFit(0)).topSpaceToView(backgroundView, kFit(5)).rightSpaceToView(self, kFit(0)).heightIs(kFit(0.5));
        
        UIButton *Btn1 = [UIButton new];
        Btn1.layer.cornerRadius = 3;
        Btn1.tag = 101;
        Btn1.layer.masksToBounds = YES;
        [Btn1 setTitle:@"商品" forState:(UIControlStateNormal)];
        Btn1.backgroundColor = MColor(242,48,48);
        Btn1.titleLabel.font = MFont(kFit(15));
        [Btn1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [Btn1 addTarget:self action:@selector(handleBtn1:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:Btn1];
        Btn1.sd_layout.leftSpaceToView(self, kFit(12)).topSpaceToView (backgroundView, kFit(10)).widthIs(kFit(60)).heightIs(kFit(30));
        
        UIButton *Btn2 = [UIButton new];
        [Btn2 setTitle:@"实体店" forState:(UIControlStateNormal)];
        Btn2.layer.cornerRadius = 3;
        Btn2.tag = 102;
        Btn2.layer.masksToBounds = YES;
        Btn2.backgroundColor = MColor(238, 238, 238);
        Btn2.titleLabel.font = MFont(kFit(15));
        [Btn2 setTitleColor:kTitle_Color forState:(UIControlStateNormal)];
        [Btn2 addTarget:self action:@selector(handleBtn1:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:Btn2];
        Btn2.sd_layout.leftSpaceToView(Btn1, kFit(5)).topSpaceToView (backgroundView, kFit(10)).widthIs(kFit(65)).heightIs(kFit(30));

        UIButton *Btn3 = [UIButton new];
        Btn3.tag = 103;
        Btn3.layer.cornerRadius = 3;
        Btn3.layer.masksToBounds = YES;
        [Btn3 setTitle:@"个人店" forState:(UIControlStateNormal)];
        Btn3.backgroundColor = MColor(238, 238, 238);
        Btn3.titleLabel.font = MFont(kFit(15));
        [Btn3 setTitleColor:kTitle_Color forState:(UIControlStateNormal)];
        [Btn3 addTarget:self action:@selector(handleBtn1:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:Btn3];
        Btn3.sd_layout.leftSpaceToView(Btn2, kFit(5)).topSpaceToView (backgroundView, kFit(10)).widthIs(kFit(65)).heightIs(kFit(30));
        
        UIButton *Btn4 = [UIButton new];
        Btn4.tag = 104;
        Btn4.layer.cornerRadius = 3;
        Btn4.layer.masksToBounds = YES;
        [Btn4 setTitle:@"便民查询" forState:(UIControlStateNormal)];
        Btn4.backgroundColor = MColor(238, 238, 238);
        Btn4.titleLabel.font = MFont(kFit(15));
        [Btn4 setTitleColor:kTitle_Color forState:(UIControlStateNormal)];
        [Btn4 addTarget:self action:@selector(handleBtn1:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:Btn4];
        Btn4.sd_layout.leftSpaceToView(Btn3, kFit(5)).topSpaceToView (backgroundView, kFit(10)).widthIs(kFit(80)).heightIs(kFit(30));

        UIButton *Btn5 = [UIButton new];
        Btn5.tag = 105;
        Btn5.layer.cornerRadius = 3;
        Btn5.layer.masksToBounds = YES;
        [Btn5 setTitle:@"厂家" forState:(UIControlStateNormal)];
        Btn5.backgroundColor = MColor(238, 238, 238);
        Btn5.titleLabel.font = MFont(kFit(15));
        [Btn5 setTitleColor:kTitle_Color forState:(UIControlStateNormal)];
        [Btn5 addTarget:self action:@selector(handleBtn1:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:Btn5];
        Btn5.sd_layout.leftSpaceToView(Btn4, kFit(5)).topSpaceToView (backgroundView, kFit(10)).widthIs(kFit(60)).heightIs(kFit(30));
    }
    return self;
}

- (void)handleCancelBtn:(UIButton *)sender {

    if ([_delegate respondsToSelector:@selector(ReturnOnALayer)]) {
        [_delegate ReturnOnALayer];
    }
}

- (void)handleBtn1:(UIButton *)sender {
    sender.backgroundColor = MColor(242,48,48);
    [sender setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
    
    int tag = (int)sender.tag;
    for (int i = 0 ; i <5; i ++) {
        if (tag != 101 + i) {
            UIButton *btn = [self viewWithTag:101 + i];
            btn.backgroundColor = MColor(238, 238, 238);
            [btn setTitleColor:kTitle_Color forState:(UIControlStateNormal)];
        }
    }
    if ([_delegate respondsToSelector:@selector(MapSearchType:)]) {
        [_delegate MapSearchType:tag];
    }
}
@end
