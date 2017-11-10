//
//  MyOrderCViewCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/29.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "MyOrderCViewCell.h"

@interface MyOrderCViewCell()<DataCollectionViewDelegate, FloorVIewDelegate>

@end

@implementation MyOrderCViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self CreatingControls];
    }
    return self;
}

- (void)CreatingControls {
    [self.contentView addSubview:self.headerView];
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"我的订单";
    titleLabel.font = MFont(kFit(15));
    [self.contentView addSubview:titleLabel];
    titleLabel.sd_layout.leftSpaceToView(self.contentView, 15).topSpaceToView(_headerView, 0).widthIs(100).heightIs(50);

    UILabel *dividerLabel = [[UILabel alloc] init];
    dividerLabel.backgroundColor = [UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1];
    [self.contentView addSubview:dividerLabel];
    dividerLabel.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(titleLabel, 3).rightSpaceToView(self.contentView, 0).heightIs(1);
    
    self.OrderView = [DataCollectionView new];
    _OrderView.Delegate = self;
    [self.contentView addSubview:self.OrderView];
    self.OrderView.sd_layout.rightSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0) .topSpaceToView(dividerLabel, 5).heightIs(kFit(60));
    
}

- (JSWave *)headerView{
    if (!_headerView) {
        _headerView = [[JSWave alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(180))];
        _headerView.backgroundColor = kNavigation_Color;
        [_headerView addSubview:self.floorView];
        _floorView.sd_layout.leftSpaceToView(_headerView, 0).topSpaceToView(_headerView, 0).widthIs(kScreen_widht).heightIs(kFit(175));
        __weak typeof(self)weakSelf = self;
        _headerView.waveBlock = ^(CGFloat currentY){
            CGRect iconFrame = [weakSelf.floorView frame];
            iconFrame.origin.y = CGRectGetHeight(weakSelf.headerView.frame)-CGRectGetHeight(weakSelf.floorView.frame)+currentY-weakSelf.headerView.waveHeight;
            weakSelf.floorView.frame  =iconFrame;
        };
        [_headerView startWaveAnimation];
    }
    return _headerView;
}

- (FloorVIew *)floorView {
    if (!_floorView) {
        _floorView = [[FloorVIew alloc] initWithFrame:CGRectMake(0, 0, kScreen_widht, kFit(170))];
        _floorView.delegate = self;
    }
    return _floorView;
}

- (void)OrderChoose:(int)index {

    if ([_delegate respondsToSelector:@selector(MyOrderChoose:)]) {
        [_delegate MyOrderChoose:index];
    }

}

- (void)DataOrIntegral:(NSInteger)index {
    
    if ([_delegate respondsToSelector:@selector(MyOrderChoose:)]) {
        [_delegate MyOrderChoose:(int)index];
    }
}
- (void)SetDefaultValue {
_floorView.nameLabel.text = @"未登录";
    _floorView.TextImage.image = [UIImage imageNamed:@"zly"];
}
- (void)setModel:(UserDataModel *)model {
    _floorView.nameLabel.text = model.memberTruename;
    [_floorView.TextImage sd_setImageWithURL:[NSString stringWithFormat:@"%@%@", kImage_URL, model.memberAvatar] placeholderImage:[UIImage imageNamed:@"jiazaishibai"]];
    _floorView.HeadPortraitImage.IntegralNumber.text = model.memberRankPoints;
    
}

@end
