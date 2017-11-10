//
//  ClassificationSearchView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ClassificationSearchView.h"

@interface ClassificationSearchView ()

@property (nonatomic, strong)UILabel *SearchContentLabel;

@end

@implementation ClassificationSearchView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        UIButton *searchBtn = [UIButton new];
        [searchBtn setImage:[UIImage imageNamed:@"GoodsSearch"] forState:(UIControlStateNormal)];
        
        [self addSubview:searchBtn];
        searchBtn.sd_layout.leftSpaceToView(self, kFit(5)).topSpaceToView(self, 0).widthIs(18).bottomSpaceToView(self, 0);
        
        self.SearchContentLabel = [UILabel new];
        _SearchContentLabel.backgroundColor = [UIColor whiteColor];
        _SearchContentLabel.text = @"分类搜索";
        _SearchContentLabel.textColor = MColor(168, 168, 168);
        _SearchContentLabel.font = MFont(kFit(14));
        [self addSubview:_SearchContentLabel];
        _SearchContentLabel.sd_layout.leftSpaceToView(searchBtn,kFit(5)).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(kFit(60));
        UIButton *drop_downBtn = [UIButton new];
        [drop_downBtn setImage:[UIImage imageNamed:@"dtxiala"] forState:(UIControlStateNormal)];
        [self addSubview:drop_downBtn];
        drop_downBtn.sd_layout.rightSpaceToView(self, kFit(5)).topSpaceToView(self, kFit(0)).bottomSpaceToView(self, 0).widthIs(6);
        
        
        UILabel *topLabel = [UILabel new];
        topLabel.userInteractionEnabled = YES;
        [self addSubview:topLabel];
        topLabel.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [topLabel addGestureRecognizer:tap];
        
        
        
    }
    return self;
}
- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(MapClassSearchClick)]) {
        
        [_delegate MapClassSearchClick];
    }
    
    
}
@end
