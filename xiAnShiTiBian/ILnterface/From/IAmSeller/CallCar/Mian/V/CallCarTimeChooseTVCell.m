//
//  CallCarTimeChooseTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/21.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CallCarTimeChooseTVCell.h"

@interface CallCarTimeChooseTVCell ()


@property (nonatomic, strong)UIButton *titleBtn;
/**
 *cell的内容
 */
@property (nonatomic, strong)UILabel *contentLabel;

/**
 *cell的标题
 */
@property (nonatomic, strong)UILabel *titleLabel;


@end

@implementation CallCarTimeChooseTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleBtn = [UIButton new];
        _titleBtn.userInteractionEnabled = NO;
        UIImage *titleImage = [UIImage imageNamed:@"SelectModels"];//
        titleImage = [titleImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_titleBtn setImage:titleImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:_titleBtn];
        _titleBtn.sd_layout.leftSpaceToView(self.contentView, kFit(0)).heightIs(kFit(50)).widthIs(kFit(40)).centerYEqualToView(self.contentView);

        self.titleLabel = [UILabel new];
        _titleLabel.text = @"车辆类型";
        _titleLabel.textColor =MColor(51, 51, 51);
        _titleLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout.leftSpaceToView(_titleBtn, kFit(5)).topSpaceToView(self.contentView, kFit(18)).heightIs(kFit(12)).widthIs(kFit(60));
        
        UIButton *arrowBtn = [UIButton new];
        UIImage *arrowImage = [UIImage imageNamed:@"qbddjt"];
        arrowImage = [arrowImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        arrowBtn.userInteractionEnabled = NO;
        [arrowBtn setImage:arrowImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:arrowBtn];
        arrowBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(50)).widthIs(kFit(40)).centerYEqualToView(self.contentView);
        
        self.contentLabel = [UILabel new];
        _contentLabel.text = @"";
        _contentLabel.textColor = MColor(255, 51, 51);
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_contentLabel];
        _contentLabel.sd_layout.leftSpaceToView(_titleLabel, kFit(10)).topEqualToView(_titleLabel).rightSpaceToView(arrowBtn, kFit(12)).heightIs(12);
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5));

        
    }
    return self;
}

- (void)ControlsAssignment:(NSDictionary *)dataDic {
    _contentLabel.text = dataDic[@"carType"];
    
}
@end
