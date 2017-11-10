



//
//  CalculateFreightTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CalculateFreightTVCell.h"

@interface CalculateFreightTVCell ()

@property (nonatomic, strong)OrderBtn *commonBtnOne;

@property (nonatomic, strong)UILabel *OrderTimeLabel;
@end

@implementation CalculateFreightTVCell

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
        [_commonBtnOne setTitle:@"计算运费" forState:(UIControlStateNormal)];
        _commonBtnOne.layer.cornerRadius = 3;
        _commonBtnOne.layer.masksToBounds = YES;
        _commonBtnOne.layer.borderWidth = 0.5;
        _commonBtnOne.layer.borderColor = [kNavigation_Color CGColor];
        _commonBtnOne.titleLabel.font = MFont(kFit(13));
        [_commonBtnOne setTitleColor:kNavigation_Color forState:(UIControlStateNormal)];
        [_commonBtnOne addTarget:self action:@selector(handleCommonBtnOne:) forControlEvents:(UIControlEventTouchUpInside)];
        [underView addSubview:_commonBtnOne];
        _commonBtnOne.sd_layout.rightSpaceToView(underView, kFit(12)).centerYEqualToView(underView).widthIs(kFit(75)).heightIs(kFit(27.5));
        
        self.OrderTimeLabel = [UILabel new];
        _OrderTimeLabel.text = @"2016-3-13";
        _OrderTimeLabel.textColor = MColor(51, 51, 51);
        _OrderTimeLabel.font = MFont(kFit(13));
        [underView addSubview:_OrderTimeLabel];
        _OrderTimeLabel.sd_layout.leftSpaceToView(underView, kFit(12)).centerYEqualToView(underView).rightSpaceToView(_commonBtnOne, 10).heightIs(kFit(13));

        
        UILabel *underLabel = [UILabel new];
        underLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:underLabel];
        underLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(underView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(10));
    }
    return self;
}

- (void)handleCommonBtnOne:(OrderBtn *)sender {
    if ([_delegate respondsToSelector:@selector(CalculateFreight:)]) {
        [_delegate CalculateFreight:sender];
    }
}
- (void)cellIndex:(NSIndexPath *)indexPath {
    
    _commonBtnOne.indexPath = indexPath;

}

- (void)setModel:(SellerOrderListModel *)model {

    _OrderTimeLabel.text = model.createTimeStr;

}

@end
