//
//  DriverHistoryOrderTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/13.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverHistoryOrderTVCell.h"

@interface DriverHistoryOrderTVCell ()


@end

@implementation DriverHistoryOrderTVCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [UILabel new];
        _titleLabel.text = @"所在地址";
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.textColor =MColor(51, 51, 51);
        _titleLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, 0).widthIs(kFit(100)).bottomSpaceToView(self.contentView, 0);
        
        UIButton *arrowBtn   = [UIButton new];
        [arrowBtn setImage:[UIImage imageNamed:@"xzz"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:arrowBtn];
        arrowBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(36);
        
        UILabel * bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5));

    }
    return self;
}
@end
