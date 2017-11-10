//
//  GuestbookContentTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/7.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "GuestbookContentTVCell.h"

@interface GuestbookContentTVCell ()


@end


@implementation GuestbookContentTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleLabel = [UILabel new];
        _titleLabel.text = @"额外服务";
        _titleLabel.textColor = MColor(51, 51, 51);
        _titleLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(16)).heightIs(kFit(14)).widthIs(kFit(70));
    
        self.contentLabel = [UILabel new];
        _contentLabel.text = @"装载,卸货等服务";
        _contentLabel.textColor = MColor(51, 51, 51);
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_contentLabel];
        _contentLabel.sd_layout.leftSpaceToView(_titleLabel, kFit(0)).topSpaceToView(self.contentView, kFit(16)).rightSpaceToView(self.contentView, kFit(12)).autoHeightRatio(0);
     
        UILabel *segmentationLabel = [[UILabel alloc] init];
        segmentationLabel.backgroundColor = MColor(210, 210, 210);
        [self.contentView addSubview:segmentationLabel];
        segmentationLabel.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(0.5).bottomSpaceToView(self.contentView, 0);
        
        [self setupAutoHeightWithBottomView:_contentLabel bottomMargin:kFit(16)];

    }
    return self;
}


@end
