//
//  CallCarPositionTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/21.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CallCarPositionTVCell.h"

@interface CallCarPositionTVCell ()

@property (nonatomic, strong)UIButton *titleBtn;
/**
 *cell的标题
 */
@property (nonatomic, strong)UILabel *locationLabel;
/**
 *cell的内容
 */
@property (nonatomic, strong)UILabel *phoneLabel;

@end

@implementation CallCarPositionTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleBtn = [UIButton new];
        _titleBtn.userInteractionEnabled = NO;
        UIImage *titleImage = [UIImage imageNamed:@"CCEndLocation"];//
        titleImage = [titleImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        [_titleBtn setImage:titleImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:_titleBtn];
        _titleBtn.sd_layout.leftSpaceToView(self.contentView, kFit(0)).heightIs(kFit(50)).widthIs(kFit(40)).centerYEqualToView(self.contentView);
        
        UIButton *arrowBtn = [UIButton new];
        UIImage *arrowImage = [UIImage imageNamed:@"qbddjt"];
        arrowImage = [arrowImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
        arrowBtn.userInteractionEnabled = NO;
        [arrowBtn setImage:arrowImage forState:(UIControlStateNormal)];
        [self.contentView addSubview:arrowBtn];
        arrowBtn.sd_layout.rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(50)).widthIs(kFit(40)).centerYEqualToView(self.contentView);

        
        self.locationLabel = [UILabel new];
        _locationLabel.text = @"浙江省北京市台州区东北街";
        _locationLabel.textColor =MColor(51, 51, 51);
        _locationLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_locationLabel];
        _locationLabel.sd_layout.leftSpaceToView(_titleBtn, kFit(5)).topSpaceToView(self.contentView, kFit(18)).heightIs(kFit(12)).rightSpaceToView(arrowBtn, kFit(12));
        
        
        self.phoneLabel = [UILabel new];
        _phoneLabel.text = @"13673384752";
        _phoneLabel.textColor = MColor(51, 51, 51);
        _phoneLabel.numberOfLines = 0;
        _phoneLabel.font = MFont(kFit(14));
        [self.contentView addSubview:_phoneLabel];
        _phoneLabel.sd_layout.leftSpaceToView(_titleBtn, kFit(5)).topSpaceToView(_locationLabel, kFit(7)).rightSpaceToView(arrowBtn, kFit(12)).heightIs(12);
        
        UILabel *bottomLabel = [UILabel new];
        bottomLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:bottomLabel];
        bottomLabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(0.5));

    }
    return self;
}
- (void)ControlsAssignment:(NSArray *)dataArray {
    UIImage *titleImage = [UIImage imageNamed:dataArray[0]];//TransportTime
    titleImage = [titleImage imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    [_titleBtn setImage:titleImage forState:(UIControlStateNormal)];
    _locationLabel.text = dataArray[1];
    _phoneLabel.text = [NSString stringWithFormat:@"电话:%@", dataArray[2]];
    
}

@end
