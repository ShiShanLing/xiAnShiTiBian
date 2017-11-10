//
//  StoreDataTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "StoreDataTVCell.h"

@interface StoreDataTVCell ()



@end

@implementation StoreDataTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [UILabel new];
        _titleLabel.text = @"测试数据";
        _titleLabel.textColor =MColor(51, 51, 51);
        _titleLabel.font = MFont(kFit(12));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(18)).heightIs(kFit(12)).widthIs(kFit(50));
        
        
        UIButton *arrowBtn = [UIButton new];
        UIImage *arrowImage = [UIImage imageNamed:@"qbddjt"];
        arrowImage = [arrowImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        arrowBtn.userInteractionEnabled = NO;
        [arrowBtn setImage:arrowImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:arrowBtn];
      //  arrowBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(50)).widthIs(kFit(40)).centerYEqualToView(self.contentView);
        
        self.contentLabel = [UILabel new];
        _contentLabel.text = @"13673384752";
        _contentLabel.textColor = MColor(134, 134, 134);
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = MFont(kFit(12));
        [self.contentView addSubview:_contentLabel];
        _contentLabel.sd_layout.leftSpaceToView(_titleLabel, kFit(10)).topEqualToView(_titleLabel).rightSpaceToView(arrowBtn, kFit(12)).autoHeightRatio(0);
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5));
        
         [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:kFit(18)];
        
    }
    return self;
    
}


@end
