//
//  ClassCVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ClassCVCell.h"

@implementation ClassCVCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = 1;
        _titleLabel.textColor = MColor(51, 51, 51);
        _titleLabel.font = MFont(kFit(12));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0);
    }
    return self;

}

@end
