//
//  SellerOrderDiscountTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/23.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "SellerOrderDiscountTVCell.h"

@interface SellerOrderDiscountTVCell()


@end


@implementation SellerOrderDiscountTVCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *middleLabel = [UILabel new];
        middleLabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:middleLabel];
        middleLabel.sd_layout.leftSpaceToView(self.contentView, kFit(0)).topSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, kFit(0)).heightIs(kFit(0.5));
        
        UIView *boyyomView = [UIView new];
        boyyomView.backgroundColor = MColor(255, 255, 255);
        [self.contentView addSubview:boyyomView];
        boyyomView.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(middleLabel, 0).rightSpaceToView(self.contentView, 0).heightIs(kFit(46));
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.textColor = MColor(51, 51, 51);
        titleLabel.text = @"订单时间";
        titleLabel.font = MFont(kFit(12));
        [boyyomView addSubview:titleLabel];
        titleLabel.sd_layout.leftSpaceToView(boyyomView, kFit(12)).centerYEqualToView(boyyomView).widthIs(kFit(100)).heightIs(kFit(12));
        
        self.GoodsDiscountLabel = [UILabel new];
        _GoodsDiscountLabel.textColor =MColor(255, 51, 51);
        _GoodsDiscountLabel.text = @"9.8折";
        _GoodsDiscountLabel.textAlignment = 2;
        _GoodsDiscountLabel.font =MFont(kFit(15));
        
        [boyyomView addSubview:_GoodsDiscountLabel];
        _GoodsDiscountLabel.sd_layout.rightSpaceToView(boyyomView, kFit(12)).widthIs(kFit(100)).heightIs(kFit(15)).centerYEqualToView(boyyomView);
        
        
        
    }
    return self;

}
@end
