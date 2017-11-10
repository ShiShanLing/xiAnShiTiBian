//
//  SearchBoxView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/27.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "SearchBoxView.h"

@implementation SearchBoxView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        UIImageView *searchImage = [UIImageView new];
        searchImage.image = [UIImage imageNamed:@"GoodsSearch"];
        [self addSubview:searchImage];
        searchImage.sd_layout.leftSpaceToView(self, kFit(25)).topSpaceToView(self, 8).widthIs(18).autoHeightRatio(1);
        
        
        
         self.titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.text = @"请输入商品名或者店铺名";
        _titleLabel.textColor = MColor(168, 168, 168);
        _titleLabel.font = MFont(kFit(14));
        [self addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(searchImage,kFit(13)).topSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)tap {

    if ([_Delegate respondsToSelector:@selector(SearchJump)]) {
        [_Delegate SearchJump];
    }

}


@end
