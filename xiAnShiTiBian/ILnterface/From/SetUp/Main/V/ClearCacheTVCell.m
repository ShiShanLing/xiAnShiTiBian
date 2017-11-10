//
//  ClearCacheTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ClearCacheTVCell.h"

@implementation ClearCacheTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"清理缓存";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(14));
        [self.contentView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(10)).widthIs(kFit(200)).heightIs(kFit(14));
        
        UILabel *subheadLabel = [UILabel new];
        subheadLabel.text = @"包括:图片,数据等";
        subheadLabel.font = MFont(kFit(12));
        subheadLabel.textColor = MColor(161, 161, 161);
        [self.contentView addSubview:subheadLabel];
        subheadLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(titleLabel, kFit(5)).widthIs(kFit(200)).heightIs(kFit(12));
        
        UIButton *arrowBtn   = [UIButton new];
        [arrowBtn setImage:[UIImage imageNamed:@"qbddjt"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:arrowBtn];
        arrowBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(36);

    }
    return self;
}
@end
