//
//  DriverDataTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/14.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverDataTVCell.h"

@interface DriverDataTVCell ()

/**
 *用户头像
 */
@property (nonatomic, strong)UIImageView *DriverImage;
/**
 *用户名
 */
@property (nonatomic, strong)UILabel *DriverNameLabel;
/**
 *司机的签名(座右铭)
 */
@property (nonatomic, strong)UILabel *DriverMottoLabel;
/**
 *显示司机的资料完成度
 */
@property (nonatomic, strong)UIButton *completeQuantityBtn;
@end

@implementation DriverDataTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *backgroundImage = [UIImageView new];
        backgroundImage.image = [UIImage imageNamed:@"wd-wssj-grxx-bjt"];
        [self.contentView addSubview:backgroundImage];
        backgroundImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
        
        self.DriverImage = [UIImageView new];
        _DriverImage.image = [UIImage imageNamed:@"zly"];
        _DriverImage.layer.borderWidth = kFit(2.5);
        _DriverImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _DriverImage.layer.cornerRadius = kFit(36);
        _DriverImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_DriverImage];
        _DriverImage.sd_layout.leftSpaceToView(self.contentView, kFit(25)).topSpaceToView(self.contentView,kFit(14)).heightIs(kFit(72)).widthIs(kFit(72));
        
        self.DriverNameLabel = [UILabel new];
        _DriverNameLabel.text = @"奔跑的石山岭";
        _DriverNameLabel.textColor = MColor(255, 255, 255);
        _DriverNameLabel.font = MFont(kFit(17));
        [self.contentView addSubview:_DriverNameLabel];
        _DriverNameLabel.sd_layout.leftSpaceToView(_DriverImage, kFit(23)).widthIs(kFit(200)).heightIs(kFit(17)).topSpaceToView(self.contentView, kFit(33));
        
        self.DriverMottoLabel = [UILabel new];
        _DriverMottoLabel.text = @"天下无难事,只怕有钱人!";
        _DriverMottoLabel.font = MFont(kFit(14));
        _DriverMottoLabel.textColor = MColor(255, 255, 255);
        [self.contentView addSubview:_DriverMottoLabel];
        _DriverMottoLabel.sd_layout.leftSpaceToView(_DriverImage, kFit(23)).widthIs(kFit(200)).heightIs(kFit(17)).topSpaceToView(_DriverNameLabel, kFit(10));
        
        UILabel *backgroundLabel = [UILabel new];
        backgroundLabel.alpha = 0.7;
        backgroundLabel.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:backgroundLabel];
        backgroundLabel.sd_layout.widthIs(kFit(325)).heightIs(kFit(30)).centerXEqualToView(self.contentView).topSpaceToView(_DriverMottoLabel, kFit(29));
        
        self.completeQuantityBtn = [UIButton new];
        [_completeQuantityBtn setTitle:@"✏️ 资料完善度100%" forState:(UIControlStateNormal)];
        _completeQuantityBtn.titleLabel.font = MFont(kFit(14));
        [_completeQuantityBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
        [self.contentView addSubview:_completeQuantityBtn];
       _completeQuantityBtn.sd_layout.widthIs(kFit(325)).heightIs(kFit(30)).centerXEqualToView(self.contentView).topSpaceToView(_DriverMottoLabel, kFit(29));
        
    }
    return self;
}


@end
