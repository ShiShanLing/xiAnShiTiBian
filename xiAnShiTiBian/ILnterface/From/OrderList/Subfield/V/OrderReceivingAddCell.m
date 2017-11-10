//
//  OrderReceivingAddCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/5/2.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "OrderReceivingAddCell.h"

@implementation OrderReceivingAddCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        self.consigneeLabel = [UILabel new];
        _consigneeLabel.text = @"收件人:石山岭";
        _consigneeLabel.font = MFont(kFit(14));
        _consigneeLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_consigneeLabel];
        _consigneeLabel.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(self.contentView, kFit(25)).widthIs(kFit(130)).heightIs(kFit(14));
        
        self.telephoneLabel = [UILabel new];
        _telephoneLabel.text = @"13673387452";
        _telephoneLabel.font = MFont(kFit(14));
        _telephoneLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_telephoneLabel];
        _telephoneLabel.sd_layout.rightSpaceToView(self.contentView, kFit(20)).topEqualToView(_consigneeLabel).leftSpaceToView(_consigneeLabel, kFit(15)).heightIs(kFit(14));
        
        self.addressLabel = [UILabel new];
        _addressLabel.text = @"收货地址 : 杭州市上城区沙地路1-2.3 \n燕语林森4栋2单元603";
        _addressLabel.font = MFont(kFit(14));
        _addressLabel.numberOfLines = 0;
        _addressLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_addressLabel];
        _addressLabel.sd_layout.leftSpaceToView(self.contentView, kFit(15)).topSpaceToView(_consigneeLabel, kFit(15)).rightSpaceToView(self.contentView, kFit(15)).heightIs(35);
        
    }
    return self;
}

@end
