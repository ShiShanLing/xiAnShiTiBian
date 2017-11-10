
//
//  AlreadyReceivingOrderTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "AlreadyReceivingOrderTVCell.h"

@interface AlreadyReceivingOrderTVCell ()
/**
 *车主名字
 */
@property (nonatomic, strong)UILabel *namelabel;
/**
 *车主电话
 */
@property (nonatomic, strong)UILabel *phoneLabel;
/**
 *车主车牌号
 */
@property (nonatomic, strong)UILabel *LicensePlateNumberLable;
/**
 *车主品牌
 */
@property (nonatomic, strong)UILabel *CarBrandLabel;
/**
 *
 */
@property (nonatomic, strong)UIImageView *HeadPortraitImage;

@end

@implementation AlreadyReceivingOrderTVCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = MColor(238, 238, 238);
        UIView *backgroundView = [UIView new];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.shadowColor = MColor(0, 0, 0).CGColor;
        backgroundView.layer.shadowOpacity = 0.3;
        backgroundView.layer.shadowOffset = CGSizeMake(0, 3);
        [self.contentView addSubview:backgroundView];
        backgroundView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, kFit(10)).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, kFit(10));
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"司机已接单";
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.font = MFont(kFit(15));
        [backgroundView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(backgroundView, kFit(12)).topSpaceToView(backgroundView, kFit(15)).widthIs(kFit(200)).heightIs(kFit(15));
        
        self.HeadPortraitImage = [UIImageView new];
        _HeadPortraitImage.image = [UIImage imageNamed:@"zly"];
        _HeadPortraitImage.layer.cornerRadius = kFit(34);
        _HeadPortraitImage.layer.masksToBounds = YES;
        [backgroundView addSubview:_HeadPortraitImage];
        _HeadPortraitImage.sd_layout.rightSpaceToView(backgroundView, kFit(12)).topSpaceToView(backgroundView, kFit(15)).widthIs(kFit(68)).heightIs(kFit(68));
        
        self.namelabel = [UILabel new];
        _namelabel.text =@"车主姓名:张三";
        _namelabel.textColor = MColor(51, 51, 51);
        _namelabel.font = MFont(kFit(14));
        [backgroundView addSubview:_namelabel];
        _namelabel.sd_layout.leftSpaceToView(backgroundView, kFit(22)).topSpaceToView(titleLabel, kFit(15)).rightSpaceToView(_HeadPortraitImage, kFit(12)).heightIs(kFit(14));
        
        self.phoneLabel = [UILabel new];
        _phoneLabel.text =@"电话:1364671****";
        _phoneLabel.textColor = MColor(51, 51, 51);
        _phoneLabel.font = MFont(kFit(14));
        [backgroundView addSubview:_phoneLabel];
        _phoneLabel.sd_layout.leftSpaceToView(backgroundView, kFit(22)).topSpaceToView(_namelabel, kFit(15)).rightSpaceToView(_HeadPortraitImage, kFit(12)).heightIs(kFit(14));
        
        self.LicensePlateNumberLable = [UILabel new];
        _LicensePlateNumberLable.text =@"车牌号:浙A888888";
        _LicensePlateNumberLable.textColor = MColor(51, 51, 51);
        _LicensePlateNumberLable.font = MFont(kFit(14));
        [backgroundView addSubview:_LicensePlateNumberLable];
        _LicensePlateNumberLable.sd_layout.leftSpaceToView(backgroundView, kFit(22)).topSpaceToView(_phoneLabel, kFit(15)).rightSpaceToView(_HeadPortraitImage, kFit(12)).heightIs(kFit(14));
        
        self.CarBrandLabel = [UILabel new];
        _CarBrandLabel.text =@"车牌号:浙A888888";
        _CarBrandLabel.textColor = MColor(51, 51, 51);
        _CarBrandLabel.font = MFont(kFit(14));
        [backgroundView addSubview:_CarBrandLabel];
        _CarBrandLabel.sd_layout.leftSpaceToView(backgroundView, kFit(22)).topSpaceToView(_LicensePlateNumberLable, kFit(15)).rightSpaceToView(_HeadPortraitImage, kFit(12)).heightIs(kFit(14));

        

    }
    return self;
}

@end
