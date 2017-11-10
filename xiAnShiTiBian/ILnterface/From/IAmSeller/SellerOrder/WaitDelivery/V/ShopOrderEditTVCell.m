//
//  ShopOrderEditTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "ShopOrderEditTVCell.h"

@interface ShopOrderEditTVCell ()

@property (nonatomic, strong)OrderBtn *commonBtnOne;
@property (nonatomic, strong)OrderBtn *commonBtnTwo;
@property (nonatomic, strong)UILabel *OrderTimeLabel;

@end


@implementation ShopOrderEditTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *middleLabel = [UILabel new];
        middleLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:middleLabel];
        middleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
        
        UIView *underView = [UIView new];
        underView.backgroundColor = MColor(255, 255, 255);
        [self.contentView addSubview:underView];
        underView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(middleLabel, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(40));
        
        self.commonBtnOne = [OrderBtn new];
        _commonBtnOne.tag = 201;
        [_commonBtnOne setTitle:@"我要叫车" forState:(UIControlStateNormal)];
        _commonBtnOne.layer.cornerRadius = 3;
        _commonBtnOne.layer.masksToBounds = YES;
        _commonBtnOne.layer.borderWidth = 0.5;
        _commonBtnOne.layer.borderColor = [kNavigation_Color CGColor];
        _commonBtnOne.titleLabel.font = MFont(kFit(13));
        [_commonBtnOne setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        [_commonBtnOne addTarget:self action:@selector(handleCommonBtnOne:) forControlEvents:(UIControlEventTouchUpInside)];
        [underView addSubview:_commonBtnOne];
        _commonBtnOne.sd_layout.rightSpaceToView(underView, kFit(12)).centerYEqualToView(underView).widthIs(kFit(75)).heightIs(kFit(27.5));
        
        self.commonBtnTwo = [OrderBtn new];
        _commonBtnTwo.tag = 202;
        [_commonBtnTwo setTitle:@"指定司机" forState:(UIControlStateNormal)];
        _commonBtnTwo.layer.cornerRadius = 3;
        _commonBtnTwo.layer.masksToBounds = YES;
        _commonBtnTwo.layer.borderWidth = 0.5;
        _commonBtnTwo.layer.borderColor = [MColor(51, 51, 51) CGColor];
        _commonBtnTwo.titleLabel.font = MFont(kFit(13));
        [_commonBtnTwo setTitleColor:MColor(51, 51, 51) forState:(UIControlStateNormal)];
        [_commonBtnTwo addTarget:self action:@selector(handleCommonBtnTwo:) forControlEvents:(UIControlEventTouchUpInside)];
        [underView addSubview:_commonBtnTwo];
        _commonBtnTwo.sd_layout.rightSpaceToView(_commonBtnOne, kFit(9)).centerYEqualToView(underView).widthIs(kFit(75)).heightIs(kFit(27.5));
    
        self.OrderTimeLabel = [UILabel new];
        _OrderTimeLabel.text = @"2016-3-13";
        _OrderTimeLabel.textColor = MColor(51, 51, 51);
        _OrderTimeLabel.font = MFont(kFit(13));
        [underView addSubview:_OrderTimeLabel];
        _OrderTimeLabel.sd_layout.leftSpaceToView(underView, kFit(12)).centerYEqualToView(underView).rightSpaceToView(_commonBtnTwo, 10).heightIs(kFit(13));
        

        
        UILabel *underLabel = [UILabel new];
        underLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:underLabel];
        underLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(underView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(10));
    }
    return self;
}
- (void)cellIndex:(NSIndexPath *)indexPath {
    
    _commonBtnOne.indexPath = indexPath;
    _commonBtnTwo.indexPath = indexPath;
    
}
/**
 *确认发货
 */
- (void)handleCommonBtnOne:(OrderBtn *)sender {

    if ([_delegate respondsToSelector:@selector(IWantCallCar:)]) {
        [_delegate IWantCallCar:sender];
    }
    
}
- (void)handleCommonBtnTwo:(OrderBtn *)sender {
    
    if ([_delegate respondsToSelector:@selector(haveAlreadyCalledCar:)]) {
        [_delegate haveAlreadyCalledCar:sender];
    }
}
- (void)setModel:(SellerOrderListModel *)model {
    _OrderTimeLabel.text = model.createTimeStr;
}

@end
