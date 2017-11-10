
//
//  StoreCoverTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "StoreCoverTVCell.h"

@interface StoreCoverTVCell ()

@end

@implementation StoreCoverTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *TopLabel = [UILabel new];//上方灰色高10的视图
        TopLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:TopLabel];
        TopLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(10));
        
        self.CoverImage = [UIImageView new];
        _CoverImage.image = [UIImage imageNamed:@"zly"];
        [self.contentView addSubview:_CoverImage];
        _CoverImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).centerYEqualToView(self.contentView).widthIs(kFit(196)).heightIs(kFit(79));
        
        UIButton *arrowBtn = [UIButton new];
        UIImage *arrowImage = [UIImage imageNamed:@"qbddjt"];
        arrowImage = [arrowImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        arrowBtn.userInteractionEnabled = NO;
        [arrowBtn setImage:arrowImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:arrowBtn];
        arrowBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(50)).widthIs(kFit(40)).centerYEqualToView(self.contentView);
        
        UILabel *titleLabel =[UILabel new];
        titleLabel.textColor = MColor(134, 134, 134);
        titleLabel.font = MFont(kFit(14));
        titleLabel.text = @"更换封面";
        titleLabel.textAlignment = 2;
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.rightSpaceToView(arrowBtn, kFit(10)).leftSpaceToView(_CoverImage, kFit(12)).heightIs(kFit(14)).centerYEqualToView(self.contentView);
        
        UILabel *UnderLabel = [UILabel new];
        UnderLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:UnderLabel];
        UnderLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(10));
        
    }
    return self;
    
}


@end
