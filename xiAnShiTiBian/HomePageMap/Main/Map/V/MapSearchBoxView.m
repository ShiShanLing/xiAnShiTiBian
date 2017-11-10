//
//  MapSearchBoxView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/5.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "MapSearchBoxView.h"

@interface MapSearchBoxView ()



@end

@implementation MapSearchBoxView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        
        self.SearchContentLabel = [UILabel new];
        _SearchContentLabel.backgroundColor = [UIColor whiteColor];
        _SearchContentLabel.text = @"输入关键字搜索";
        _SearchContentLabel.textColor = MColor(168, 168, 168);
        _SearchContentLabel.font = MFont(kFit(14));
        [self addSubview:_SearchContentLabel];
        _SearchContentLabel.sd_layout.leftSpaceToView(self,kFit(5)).topSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self,kFit(0));
        
        UIButton *DeleteRecordsBtn = [UIButton new];
        [DeleteRecordsBtn setImage:[UIImage imageNamed:@"dtgb"] forState:(UIControlStateNormal)];
        [DeleteRecordsBtn addTarget:self action:@selector(handleDeleteRecordsBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:DeleteRecordsBtn];
        DeleteRecordsBtn.sd_layout.rightSpaceToView(self, kFit(0)).topSpaceToView(self, 0).bottomSpaceToView(self, 0).widthIs(29);

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)handleDeleteRecordsBtn {


    
}
- (void)handleTap:(UITapGestureRecognizer *)tap {
    if ([_delegate respondsToSelector:@selector(MapMainSearchClick)]) {
        [_delegate MapMainSearchClick];
    }


}

@end
