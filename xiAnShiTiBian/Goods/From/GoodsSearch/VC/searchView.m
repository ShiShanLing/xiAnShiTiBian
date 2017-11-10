//
//  searchView.m
//  搜索页面的封装
//
//  Created by 石山岭 on 2016/12/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "searchView.h"
#import "UIView+SDAutoLayout.h" //第三方布局

#define MFont(f) [UIFont systemFontOfSize:f]
#define kIphone6Height 667.0
#define kIphone6Width 375.0
#define YouLikeLineCount 2
#define YouLikeCellW ((SScreen_Width - YouLikeInset * (YouLikeLineCount - 1)) / YouLikeLineCount) * 1.0
#define YouLikeInset kFit(6)
#define YouLikeCellH kFit((250 - YouLikeInset))
#define SScreen_Width [UIScreen mainScreen].bounds.size.width
#define SScreen_Height [UIScreen mainScreen].bounds.size.height
#define kFit(x) (SScreen_Width*((x)/kIphone6Width))
#define MColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0f]

#define TextSize kFit(16)

@implementation searchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backgroundView = [UIView new];
        backgroundView.layer.cornerRadius = 3;
        backgroundView.layer.masksToBounds = YES;
        backgroundView.backgroundColor = MColor(238, 238, 238);
        [self addSubview:backgroundView];
        backgroundView.sd_layout.leftSpaceToView(self, kFit(12)).topSpaceToView(self, 22).bottomSpaceToView(self, 2).widthIs(kFit(311));
                
        self.titleLabel = [UILabel new];
        _titleLabel.text = @"商品";
        _titleLabel.textAlignment = 1;
        _titleLabel.textColor = MColor(134, 134, 134);
        _titleLabel.font = MFont(kFit(15));
        _titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer  *titleLabelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTypeBtn)];
        [_titleLabel addGestureRecognizer:titleLabelTap];
        [backgroundView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(backgroundView, 0).topSpaceToView(backgroundView, 0).bottomSpaceToView(backgroundView, 0).widthIs(kFit(57));
        
        self.typeBtn = [UIButton new];
        [_typeBtn setImage:[UIImage imageNamed:@"huixia"] forState:(UIControlStateNormal)];
        [_typeBtn setImage:[UIImage imageNamed:@"huishang"] forState:(UIControlStateSelected)];
        [_typeBtn addTarget:self action:@selector(handleTypeBtn) forControlEvents:(UIControlEventTouchUpInside)];
        
        [backgroundView addSubview:_typeBtn];
        _typeBtn.sd_layout.leftSpaceToView(_titleLabel, 0).topSpaceToView(backgroundView, 0).bottomSpaceToView(backgroundView, 0).widthIs(kFit(8));

        self.searchTF = [UITextField new];
        _searchTF.delegate = self;
        _searchTF.returnKeyType = UIReturnKeySearch;
        _searchTF.placeholder = @"请输入";
        _searchTF.font = [UIFont systemFontOfSize:kFit(14)];
        _searchTF.textColor = [UIColor blackColor];
        [backgroundView addSubview:_searchTF];
        _searchTF.sd_layout.leftSpaceToView(_typeBtn, kFit(15)).topSpaceToView(backgroundView, 0).bottomSpaceToView(backgroundView, 0).rightSpaceToView(backgroundView, 0);
        
        self.cancelBtn = [UIButton new];
        [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kFit(15)];
        [_cancelBtn addTarget:self action:@selector(handleCancelBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_cancelBtn];
        _cancelBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, kFit(22)).bottomSpaceToView(self, kFit(2)).leftSpaceToView(backgroundView, 0);
        
    }
    return self;

}

- (void)handleTypeBtn {

  
    
    if ([_delegate respondsToSelector:@selector(ChangeSearchType)]) {
        [_delegate ChangeSearchType];
    }
    
}
- (void)handleCancelBtn:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(ReturnOnALayer)]) {
        [_delegate ReturnOnALayer];
    }

}

@end
