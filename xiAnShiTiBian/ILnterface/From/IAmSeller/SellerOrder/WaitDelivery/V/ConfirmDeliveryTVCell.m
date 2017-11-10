//
//  ConfirmDeliveryTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ConfirmDeliveryTVCell.h"

@interface ConfirmDeliveryTVCell()

@property (nonatomic, strong)OrderBtn * ConfirmDeliveryBtnOne;
@property (nonatomic, strong)OrderBtn *ConfirmDeliveryBtnTwo;
@property (nonatomic, strong)UILabel *OrderTimeLabel;
@end

@implementation ConfirmDeliveryTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *middleLabel = [UILabel new];
        middleLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:middleLabel];
        middleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
        
        UIView *underView = [UIView new];
        underView.backgroundColor = MColor(255, 255, 255);
        [self.contentView addSubview:underView];
        underView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(middleLabel, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(40));
        
        self.ConfirmDeliveryBtnOne = [OrderBtn new];
        _ConfirmDeliveryBtnOne.tag = 201;
        [_ConfirmDeliveryBtnOne setTitle:@"确认发货" forState:(UIControlStateNormal)];
        _ConfirmDeliveryBtnOne.layer.cornerRadius = 3;
        _ConfirmDeliveryBtnOne.layer.masksToBounds = YES;
        _ConfirmDeliveryBtnOne.layer.borderWidth = 0.5;
        _ConfirmDeliveryBtnOne.layer.borderColor = [kNavigation_Color CGColor];
        _ConfirmDeliveryBtnOne.titleLabel.font = MFont(kFit(13));
        [_ConfirmDeliveryBtnOne setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        [_ConfirmDeliveryBtnOne addTarget:self action:@selector(handleCommonBtnOne:) forControlEvents:(UIControlEventTouchUpInside)];
        [underView addSubview:_ConfirmDeliveryBtnOne];
        _ConfirmDeliveryBtnOne.sd_layout.rightSpaceToView(underView, kFit(12)).centerYEqualToView(underView).widthIs(kFit(75)).heightIs(kFit(27.5));
        
        self.ConfirmDeliveryBtnTwo = [OrderBtn new];
        _ConfirmDeliveryBtnTwo.tag = 202;
        [_ConfirmDeliveryBtnTwo setTitle:@"叫车详情" forState:(UIControlStateNormal)];
        _ConfirmDeliveryBtnTwo.layer.cornerRadius = 3;
        _ConfirmDeliveryBtnTwo.layer.masksToBounds = YES;
        _ConfirmDeliveryBtnTwo.layer.borderWidth = 0.5;
        _ConfirmDeliveryBtnTwo.layer.borderColor = [MColor(51, 51, 51) CGColor];
        _ConfirmDeliveryBtnTwo.titleLabel.font = MFont(kFit(13));
        [_ConfirmDeliveryBtnTwo setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        [_ConfirmDeliveryBtnTwo addTarget:self action:@selector(handleCommonBtnTwo:) forControlEvents:(UIControlEventTouchUpInside)];
     //   [underView addSubview:_ConfirmDeliveryBtnTwo];
     //   _ConfirmDeliveryBtnTwo.sd_layout.rightSpaceToView(_ConfirmDeliveryBtnOne, kFit(12)).centerYEqualToView(underView).widthIs(kFit(75)).heightIs(kFit(27.5));
        
        
        self.OrderTimeLabel = [UILabel new];
        _OrderTimeLabel.text = @"2016-3-13";
        _OrderTimeLabel.textColor = MColor(51, 51, 51);
        _OrderTimeLabel.font = MFont(kFit(13));
        [underView addSubview:_OrderTimeLabel];
        _OrderTimeLabel.sd_layout.leftSpaceToView(underView, kFit(12)).centerYEqualToView(underView).rightSpaceToView(_ConfirmDeliveryBtnOne, 10).heightIs(kFit(13));
        
        UILabel *underLabel = [UILabel new];
        underLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:underLabel];
        underLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(underView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(10));

        
    }
    return self;
}

- (void)handleCommonBtnOne:(OrderBtn *)sender {
    
    
    if ([_delegate respondsToSelector:@selector(ConfirmDeliveryBtn:)]) {
        [_delegate ConfirmDeliveryBtn:nil];
    }
    
}
- (void)handleCommonBtnTwo:(OrderBtn *)sender {
    
    if ([_delegate respondsToSelector:@selector(SeeCallCarDetails:)]) {
        [_delegate SeeCallCarDetails:sender];
    }
}
- (void)setModel:(SellerOrderListModel *)model {

    _OrderTimeLabel.text = model.createTimeStr;
}
@end
