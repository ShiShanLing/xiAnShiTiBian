//
//  DriverDataTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/11.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "DriverStateTVCell.h"

@interface  DriverStateTVCell()
/**
 *用户头像
 */
@property (nonatomic, strong)UIImageView *DriverImage;
/**
 *用户名
 */
@property (nonatomic, strong)UILabel *DriverNameLabel;
/**
 *车型
 */
@property (nonatomic, strong)UILabel *carTypeLabel;
/**
 *下线
 */
@property (nonatomic, strong)UIButton *offlineBtn;
/**
 *查看先接的订单
 */
@property (nonatomic, strong)UIButton *checkOrderBtn;
@end

@implementation DriverStateTVCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *backgroundImage = [UIImageView new];
        backgroundImage.image = [UIImage imageNamed:@"wd-wssj-bjt"];
        [self.contentView addSubview:backgroundImage];
        backgroundImage.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0);
        
        self.DriverImage = [UIImageView new];
        _DriverImage.image = [UIImage imageNamed:@"zly"];
        _DriverImage.layer.borderWidth = kFit(2.5);
        _DriverImage.layer.borderColor = [UIColor whiteColor].CGColor;
        _DriverImage.layer.cornerRadius = kFit(45);
        _DriverImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_DriverImage];
        _DriverImage.sd_layout.leftSpaceToView(self.contentView, kFit(36)).centerYEqualToView(self.contentView).heightIs(kFit(90)).widthIs(kFit(90));
        
        self.DriverNameLabel = [UILabel new];
        _DriverNameLabel.text = @"奔跑的石山岭";
        _DriverNameLabel.textColor = MColor(255, 255, 255);
        _DriverNameLabel.font = MFont(kFit(17));
        [self.contentView addSubview:_DriverNameLabel];
        _DriverNameLabel.sd_layout.rightSpaceToView(self.contentView, kFit(12)).widthIs(kFit(150)).heightIs(kFit(17)).topSpaceToView(self.contentView, kFit(25));
        
        self.carTypeLabel = [UILabel new];
        _carTypeLabel.text = @"车型:长安火车";
        _carTypeLabel.font = MFont(kFit(14));
        _carTypeLabel.textColor = MColor(255, 255, 255);
        [self.contentView addSubview:_carTypeLabel];
        _carTypeLabel.sd_layout.rightSpaceToView(self.contentView, kFit(12)).widthIs(kFit(150)).heightIs(kFit(14)).topSpaceToView(_DriverNameLabel, kFit(20));
        
        self.offlineBtn = [UIButton new];
        [_offlineBtn setTitle:@"下线" forState:(UIControlStateNormal)];
        [_offlineBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
        [_offlineBtn setTitle:@"上线" forState:(UIControlStateSelected)];
        [_offlineBtn setTitleColor:MColor(134, 134, 134) forState:(UIControlStateSelected)];
        _offlineBtn.layer.cornerRadius = 4;
        _offlineBtn.titleLabel.font = MFont(kFit(14));
        _offlineBtn.layer.masksToBounds = YES;
        _offlineBtn.backgroundColor = MColor(0, 206, 165);
        
        [_offlineBtn addTarget:self action:@selector(handleOfflineBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.contentView addSubview:_offlineBtn];
        _offlineBtn.sd_layout.rightSpaceToView(self.contentView, kFit(115)).widthIs(kFit(50)).heightIs(kFit(30)).topSpaceToView(_carTypeLabel, kFit(20));
    
        self.checkOrderBtn = [UIButton new];
        [_checkOrderBtn setTitle:@"查看订单" forState:(UIControlStateNormal)];
        _checkOrderBtn.layer.cornerRadius = 4;
        _checkOrderBtn.titleLabel.font = MFont(kFit(14));
        _checkOrderBtn.layer.masksToBounds = YES;
        _checkOrderBtn.backgroundColor = MColor(0, 206, 165);
        [_checkOrderBtn setTitleColor:MColor(255, 255, 255) forState:(UIControlStateNormal)];
        [_checkOrderBtn addTarget:self action:@selector(handleCheckOrderBtn) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_checkOrderBtn];
        _checkOrderBtn.sd_layout.leftSpaceToView(_offlineBtn, kFit(10)).widthIs(kFit(80)).heightIs(kFit(30)).topSpaceToView(_carTypeLabel, kFit(20));
    }
    return self;
}

- (void)handleOfflineBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([_delegate respondsToSelector:@selector(handleOfflineBtn)]) {
        [_delegate handleOfflineBtn];
    }
}

- (void)handleCheckOrderBtn {
    if ([_delegate respondsToSelector:@selector(handleCheckOrderBtn)]) {
        [_delegate handleCheckOrderBtn];
    }
}


-(void)setModel:(DriverDataModel *)model {
    _model = model;
    
    _DriverNameLabel.text = model.carOwnerName;
    _carTypeLabel.text = [NSString stringWithFormat:@"车型 :%@", model.carVehicleBrand];
}
@end
