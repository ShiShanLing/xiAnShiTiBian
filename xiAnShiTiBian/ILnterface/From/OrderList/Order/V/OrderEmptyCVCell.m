//
//  OrderEmptyCVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/12.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderEmptyCVCell.h"

@implementation OrderEmptyCVCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.stateImage = [UIImageView new];
        _stateImage.image = [UIImage imageNamed:@"mydd"];
        [self.contentView addSubview:_stateImage];
        _stateImage.sd_layout.topSpaceToView(self.contentView, kFit(107)).widthIs(kFit(70)).heightIs(kFit(70)).centerXEqualToView(self.contentView);
        
        self.titleLabel = [UILabel new];
        _titleLabel.textAlignment = 1;
        _titleLabel.text = @"您还没有相关的订单";
        _titleLabel.font = MFont(kFit(17));
        _titleLabel.textColor = MColor(0, 0, 0);
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(_stateImage, kFit(35)).heightIs(kFit(17));
        
        self.subheadLabel = [UILabel new];
        _subheadLabel.textColor= MColor(161, 161, 161);
        _subheadLabel.text = @"可以去看看有哪些想买的";
        _subheadLabel.textAlignment = 1;
        _subheadLabel.font = MFont(kFit(11));
        [self.contentView addSubview:_subheadLabel];
        _subheadLabel.sd_layout.leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).topSpaceToView(_titleLabel, kFit(35)).heightIs(kFit(11));
        
    }
    return self;

}

@end
