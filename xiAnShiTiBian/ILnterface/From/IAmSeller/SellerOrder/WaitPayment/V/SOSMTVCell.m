//
//  SOSMTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/17.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SOSMTVCell.h"

@interface SOSMTVCell ()
/**
 *显示货运方式的cell
 */
@property (nonatomic, strong)UILabel *ShippingWayLabel;

@property (nonatomic, strong)UILabel *OrderTimeLabel;
@end

@implementation SOSMTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *middleLabel = [UILabel new];
        middleLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:middleLabel];
        middleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
        UIView *boyyomView = [UIView new];
        boyyomView.backgroundColor = MColor(255, 255, 255);
        [self.contentView addSubview:boyyomView];
        boyyomView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(middleLabel, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(46));
        
        
        self.ShippingWayLabel = [UILabel new];
        _ShippingWayLabel.textColor =MColor(161, 161, 161);
        _ShippingWayLabel.text = @"商家承包";
        _ShippingWayLabel.textAlignment = 2;
        _ShippingWayLabel.font =MFont(kFit(12));
        [boyyomView addSubview:_ShippingWayLabel];
        _ShippingWayLabel.sd_layout.rightSpaceToView(boyyomView, kFit(12)).widthIs(kFit(100)).heightIs(kFit(12)).centerYEqualToView(boyyomView);
        

        self.OrderTimeLabel = [UILabel new];
        _OrderTimeLabel.text = @"2016-3-13";
        _OrderTimeLabel.textColor = MColor(51, 51, 51);
        _OrderTimeLabel.font = MFont(kFit(13));
        [boyyomView addSubview:_OrderTimeLabel];
        _OrderTimeLabel.sd_layout.leftSpaceToView(boyyomView, kFit(12)).centerYEqualToView(boyyomView).rightSpaceToView(_ShippingWayLabel, 10).heightIs(kFit(13));

        
        UILabel *underLabel = [UILabel new];
        underLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:underLabel];
        underLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(10));
    }
    return self;
}

- (void)OrderStateBtn:(int)state {
    if (state == 0) {
        _ShippingWayLabel.text = @"货运方式:全部   ";
    }
    if (state == 1) {
        _ShippingWayLabel.text = @"货运方式:商家承包";
    }
    
    if (state == 2) {
        _ShippingWayLabel.text = @"货运方式:买家自提";
    }

}

-(void)setModel:(SellerOrderListModel *)model {

    _OrderTimeLabel.text = model.createTimeStr;
}
@end
