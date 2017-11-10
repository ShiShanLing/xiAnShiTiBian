//
//  ConfirmShippingAddressTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/16.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ConfirmShippingAddressTVCell.h"

@implementation ConfirmShippingAddressTVCell
/*
consigneeLabel;
telephoneLabel;
addressLabel;
detailsLabel;
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.consigneeLabel = [UILabel new];
        _consigneeLabel.text = @"";
        _consigneeLabel.font = MFont(kFit(14));
        _consigneeLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_consigneeLabel];
        _consigneeLabel.sd_layout.leftSpaceToView(self.contentView, kFit(37)).topSpaceToView(self.contentView, kFit(25)).widthIs(kFit(130)).heightIs(kFit(14));
        
        self.telephoneLabel = [UILabel new];
        _telephoneLabel.text = @"";
        _telephoneLabel.font = MFont(kFit(14));
        _telephoneLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_telephoneLabel];
        _telephoneLabel.sd_layout.rightSpaceToView(self.contentView, kFit(20)).topSpaceToView(self.contentView, kFit(25)).leftSpaceToView(_consigneeLabel, kFit(15)).heightIs(kFit(14));
        
        UIImageView *arrowImage = [UIImageView new];//右箭头图标
        arrowImage.image = [UIImage imageNamed:@"jt"];
        [self.contentView addSubview:arrowImage];
        arrowImage.sd_layout.rightSpaceToView(self.contentView, kFit(12)).widthIs(kFit(10)).heightIs(kFit(19)).topSpaceToView(self.telephoneLabel, kFit(25));
        
        UIImageView *locationImage = [UIImageView new];//定位图标
        locationImage.image = [UIImage imageNamed:@"cfdz"];
        [self.contentView addSubview:locationImage];
        locationImage.sd_layout.leftSpaceToView(self.contentView, kFit(12)).topSpaceToView(_consigneeLabel, kFit(17)).widthIs(kFit(16)).heightIs(kFit(25));

        self.addressLabel = [UILabel new];
        _addressLabel.text = @"收货地址 : 杭州市上城区沙地路1-2.3 \n燕语林森4栋2单元603";
        _addressLabel.font = MFont(kFit(14));
        _addressLabel.numberOfLines = 0;
        _addressLabel.textColor = MColor(51, 51, 51);
        [self.contentView addSubview:_addressLabel];
        _addressLabel.sd_layout.leftSpaceToView(locationImage, kFit(15)).topSpaceToView(_consigneeLabel, kFit(15)).rightSpaceToView(arrowImage, kFit(15)).heightIs(35);
        
        UILabel *segmentationlabel = [UILabel new];
        segmentationlabel.backgroundColor = MColor(238, 238, 238);
        [self.contentView addSubview:segmentationlabel];
        segmentationlabel.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, 0).heightIs(kFit(4));
        
        UIImageView *segmentationImage = [UIImageView new];
        segmentationImage.image = [UIImage imageNamed:@"biankuang"];
        [self.contentView addSubview:segmentationImage];
        segmentationImage.sd_layout.leftSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0.5).rightSpaceToView(self.contentView, 0).heightIs(kFit(4));
    }
    return self;
}

- (void)setModel:(ShippingAddressModel *)model {
    if (model.trueName.length == 0) {
        _addressLabel.font = MFont(kFit(16));
        _addressLabel.text = @"选择地址";
        
    }else {
    _consigneeLabel.text = model.trueName;
    _telephoneLabel.text = model.mobPhone;
    _addressLabel.text = [NSString stringWithFormat:@"收货地址 :%@ \n%@", model.address, model.areaInfo];
    }

}

@end
